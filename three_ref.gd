@tool
extends Node
# SOURCE: https://godotengine.org/qa/6369/how-to-get-the-editors-camera

# after the _ready(), these should all be available
var _editor_interface : EditorInterface
var _editor_viewports : Array = []
var _editor_cameras : Array = []
# expose the most common two to the editor, for easy access.
# most of the time, we don't need the whole array.
var _camera: Camera3D
var _viewport: Viewport

func _ready():
    _find_viewports(get_tree().get_root())
    print("EditorRef - 3D: found these viewports:")
    print(_editor_viewports)
    for v in _editor_viewports:
        _find_cameras(v)

    print("EditorRef - 3D: found these cameras:")
    print(_editor_cameras)
    if _editor_cameras.size() > 0:
        _camera = _editor_cameras[0]
        _viewport = _camera.get_viewport()

const NODE_3D_VIEWPORT_CLASS_NAME = "Node3DEditorViewport"
func _find_viewports(n : Node):
    if n.get_class() == NODE_3D_VIEWPORT_CLASS_NAME:
        _editor_viewports.append(n)

    for c in n.get_children():
        _find_viewports(c)

func _find_cameras(n: Node):
    if n is Camera3D:
        _editor_cameras.append(n)

    for c in n.get_children():
        _find_cameras(c)