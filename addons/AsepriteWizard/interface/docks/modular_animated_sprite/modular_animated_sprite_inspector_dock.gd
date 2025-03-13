@tool
extends "../base_inspector_dock.gd"

const AnimationCreator = preload("../../../creators/modular_animation/modular_animation_creator.gd")
const SpriteAnimationCreator = preload("../../../creators/modular_animation/modular_sprite_animation_creator.gd")
const TextureRectAnimationCreator = preload("../../../creators/modular_animation/modular_texture_rect_animation_creator.gd")
const StaticTextureCreator = preload("../../../creators/static_texture/texture_creator.gd")

var animation_creator: AnimationCreator
var static_texture_creator: StaticTextureCreator

# animation
@onready var _animation_section := $dock_fields/VBoxContainer/extra/sections/animation as VBoxContainer
@onready var _animation_section_header := $dock_fields/VBoxContainer/extra/sections/animation/section_header as Button
@onready var _animation_section_container := $dock_fields/VBoxContainer/extra/sections/animation/section_content as MarginContainer
@onready var _cleanup_hide_unused_nodes :=  $dock_fields/VBoxContainer/extra/sections/animation/section_content/content/auto_visible_track/CheckBox as CheckBox
@onready var _keep_length :=  $dock_fields/VBoxContainer/extra/sections/animation/section_content/content/keep_length/CheckBox as CheckBox

const INTERFACE_SECTION_KEY_ANIMATION = "animation_section"


func _pre_setup():
	_expandable_sections[INTERFACE_SECTION_KEY_ANIMATION] = { "header": _animation_section_header, "content": _animation_section_container}

func _setup():
	if target_node is ModularAnimatedSprite2D:
		animation_creator = SpriteAnimationCreator.new()
	if target_node is TextureRect:
		animation_creator = TextureRectAnimationCreator.new()

	static_texture_creator = StaticTextureCreator.new()

func _load_config(cfg):
	_cleanup_hide_unused_nodes.button_pressed = cfg.get("set_vis_track", config.is_set_visible_track_automatically_enabled())
	_keep_length.button_pressed = cfg.get("keep_anim_length", false)


func _load_default_config():
	_cleanup_hide_unused_nodes.button_pressed = config.is_set_visible_track_automatically_enabled()


enum {
	FILE_EXPORT_MODE,
	LAYERS_EXPORT_MODE
}

func _do_import():
	await _import_for_animation_player()

##
## Import aseprite animations to target AnimationPlayer and set
## spritesheet as the node's texture
##
func _import_for_animation_player():
	var root = get_tree().get_edited_scene_root()

	var source_path = ProjectSettings.globalize_path(_source)

	var options = _get_import_options(root.scene_file_path.get_base_dir())
	options.export_mode = LAYERS_EXPORT_MODE

	_save_config()

	var aseprite_output = _aseprite_file_exporter.generate_aseprite_files(source_path, options)

	if not aseprite_output.is_ok:
		_notify_aseprite_error(aseprite_output.code)
		return

	file_system.scan()
	await file_system.filesystem_changed

	var anim_layers
	if !options.layers.is_empty():
		anim_layers = options.layers.filter(func(layer): return layer != "")
	else:
		anim_layers = self._fetch_layers().filter(func(layer): return layer != "")

	var anim_options = {
		"keep_anim_length": _keep_length.button_pressed,
		"cleanup_hide_unused_nodes": _cleanup_hide_unused_nodes.button_pressed,
		"slice": _slice,
		"should_create_portable_texture": _embed_field.button_pressed,
		"layers": anim_layers
	}
	
	animation_creator.create_nodes_and_animations(aseprite_output.content, anim_options)
	_importing = false

	wizard_config.set_source_hash(target_node, FileAccess.get_md5(source_path))
	_handle_cleanup(aseprite_output.content, _embed_field.button_pressed)

##
## Import first frame from aseprite file as node texture
##
func _import_static():
	var source_path = ProjectSettings.globalize_path(_source)
	var root = get_tree().get_edited_scene_root()

	var options = _get_import_options(root.scene_file_path.get_base_dir())
	options["first_frame_only"] = true

	_save_config()

	var aseprite_output = _aseprite_file_exporter.generate_aseprite_file(source_path, options)

	if not aseprite_output.is_ok:
		_notify_aseprite_error(aseprite_output.code)
		return

	file_system.scan()
	await file_system.filesystem_changed

	static_texture_creator.load_texture(target_node, aseprite_output.content, {
		"slice": _slice,
		"should_create_portable_texture": _embed_field.button_pressed,
	})

	_importing = false
	wizard_config.set_source_hash(target_node, FileAccess.get_md5(source_path))
	_handle_cleanup(aseprite_output.content, _embed_field.button_pressed)


func _get_current_field_values() -> Dictionary:
	var cfg := {
		"keep_anim_length": _keep_length.button_pressed,
	}

	if _cleanup_hide_unused_nodes.button_pressed != config.is_set_visible_track_automatically_enabled():
		cfg["set_vis_track"] = _cleanup_hide_unused_nodes.button_pressed

	return cfg


func _get_available_layers(global_source_path: String) -> Array:
	return animation_creator.list_layers(global_source_path)


func _get_available_slices(global_source_path: String) -> Array:
	return animation_creator.list_slices(global_source_path)


func _on_animation_header_button_down():
	_toggle_section_visibility(INTERFACE_SECTION_KEY_ANIMATION)


func _show_specific_fields():
	_animation_section.show()
