extends Spatial

export var show_text_input := true;
# if 'show_text_input' is enabled and this flag is set ture, then
# the text input box will aquire focus when then keyboard gains visibilty
export var focus_on_visible := true;

var _text_edit : TextEdit = null;
var _keyboard = null;

signal text_input_cancel();
signal text_input_enter(text);


func _on_cancel():
	emit_signal("text_input_cancel");
	_text_edit.text = "";


func _on_enter():
	emit_signal("text_input_enter", _text_edit.text);
	_text_edit.text = "";


func _ready():
	_text_edit = $OQ_UI2DCanvas_TextInput.find_node("TextEdit", true, false);
	_keyboard = $OQ_UI2DCanvas_Keyboard.find_node("VirtualKeyboard", true, false);
	
	if (show_text_input):
		_keyboard.connect("cancel_pressed", self, "_on_cancel");
		_keyboard.connect("enter_pressed", self, "_on_enter");
	
	if (show_text_input):
		$OQ_UI2DCanvas_TextInput.visible = true;
		_text_edit.grab_focus();
	else:
		$OQ_UI2DCanvas_TextInput.visible = false; # ?? maybe delte the node if not used

func _on_OQ_UI2DKeyboard_visibility_changed():
	if visible and show_text_input and focus_on_visible:
		_text_edit.grab_focus()
