class_name ParallelCoroutine
extends Object
# Allows for multiple coroutines to be awaited without race conditions

# Written by https://godotengine.org/qa/147012/join-multiple-coroutines-await-waits-only-single-coroutine

signal completed

var queued_coroutines: Array[Dictionary]
var total_count: int
var completed_count: int

func append(object: Object, params: Array, call_method: StringName, complete_signal: StringName) -> void:
	queued_coroutines.append({'object': object, 'params': params, 'call_method': call_method, 'complete_signal': complete_signal})

func run_all() -> void:
	total_count = queued_coroutines.size()
	for routine in queued_coroutines:
		var object: Object = routine['object']
		var params: Array = routine['params']
		var call_method: StringName = routine['call_method']
		var complete_signal: StringName = routine['complete_signal']
		object.callv(call_method, params)
		object.connect(complete_signal, _on_completed)
	if total_count == 0:
		call_deferred("emit_signal", "completed")

func _on_completed() -> void:
	completed_count = completed_count + 1
	if completed_count == total_count:
		completed.emit()
