@tool
extends EditorPlugin

const TWO_NAME: String = "Ref2D"
const THREE_NAME: String = "Ref3D"

func _enter_tree() -> void:
    add_autoload_singleton(TWO_NAME, "res://addons/editor_ref/two_ref.gd")
    add_autoload_singleton(THREE_NAME, "res://addons/editor_ref/three_ref.gd")
    # grab all of the references we want initially, then they're exposed from the singleton to
    # all the other plugins.

func _exit_tree() -> void:
    remove_autoload_singleton(TWO_NAME)
    remove_autoload_singleton(THREE_NAME)

