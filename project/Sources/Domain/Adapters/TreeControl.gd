class_name TreeControl
extends Reference

static func reparent(child: Node, a: Node, b: Node):
	a.remove_child(child)
	b.add_child(b)
