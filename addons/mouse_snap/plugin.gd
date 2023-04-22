@tool
extends EditorPlugin

# Define your shortcut key combination here
const SHORTCUT = KEY_M

const DEPENDENCIES: Array[String] = [
    "editor_ref"
]

func _input(event):
    # Check if the shortcut key combination is pressed
    if event is InputEventKey and event.pressed and event.keycode == SHORTCUT:
        _move_selected_node_to_mouse_position()

func _move_selected_node_to_mouse_position() -> void:
    var selected: Array = get_editor_interface().get_selection().get_selected_nodes()
    if selected.size() == 0:
        printerr("No nodes selected, returning.")
        return
    for node in selected:
        if node is Node3D:
            var mouse_pos = Ref3D._viewport.get_mouse_position()
            var world_pos = _get_world_position_from_mouse_position(Ref3D._camera, mouse_pos)
            node.global_transform.origin = world_pos
        else:
            printerr("Selected node is not a Node3D, skipping. (", node.name, ")")

func _get_world_position_from_mouse_position(camera, mouse_pos) -> Vector3:
    var from = camera.project_ray_origin(mouse_pos)
    var to = from + camera.project_ray_normal(mouse_pos) * 1000
    var space_state = get_tree().get_root().get_world_3d().direct_space_state

    var rayOrigin = camera.project_ray_origin(mouse_pos)
    var query = PhysicsRayQueryParameters3D.create(
        rayOrigin,
        camera.project_ray_normal(mouse_pos) * 2000
    )
    var result = space_state.intersect_ray(query)

    if result.size() > 0:
        return result.position
    else:
        return Vector3.ZERO

func handles(object):
    return object is Node3D
