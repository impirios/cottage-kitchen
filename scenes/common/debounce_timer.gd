class_name Debouncetimer extends Node

var debounce_timer: Timer

func init_debounce_timer(debounce_time: float, callback, root_node: Node):
		debounce_timer = Timer.new()
		debounce_timer.wait_time = debounce_time
		root_node.add_child(debounce_timer)
		debounce_timer.connect('timeout', callback)


func start_process():
		if debounce_timer.is_stopped():
				debounce_timer.start()

func stop_process():
		debounce_timer.stop()