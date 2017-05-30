ScriptName Gambling:Common Hidden
import Gambling:Context

; Logging
;---------------------------------------------

bool Function WriteLine(string prefix, string text) Global DebugOnly
	string filename = GetTitle() const
	text = prefix + " " + text
	If(Debug.TraceUser(filename, text))
		return true
	Else
		Debug.OpenUserLog(filename)
		return Debug.TraceUser(filename, text)
	EndIf
EndFunction


bool Function WriteNotification(string prefix, string text) Global DebugOnly
	Debug.Notification(text)
	return WriteLine(prefix, text)
EndFunction


bool Function WriteMessage(string prefix, string text) Global DebugOnly
	Debug.MessageBox(text)
	return WriteLine(prefix, text)
EndFunction


; Scripts
;---------------------------------------------

bool Function ChangeState(ScriptObject script, string newState) Global
	string stateName = script.GetState()

	If(stateName != newState)
		script.GoToState(newState)
		return true
	Else
		return false
	EndIf
EndFunction


bool Function HasState(ScriptObject script) Global
	return script.GetState() != ""
EndFunction


; Arrays
;---------------------------------------------

bool Function ArrayIsCapacity(var[] array)
	return array && array.Length >= 128
EndFunction


; Spatial
;---------------------------------------------

Struct Point
	float X = 0.0
	float Y = 0.0
	float Z = 0.0
EndStruct


string Function PointToString(Point value) Global
	{Returns a string that represents the Point.}
	return "X:"+value.X+", Y:"+value.Y+", Z:"+value.Z
EndFunction


Point Function PointAddition(Point value, Point other) Global
	{Adds two Point structures and returns the result as a Point structure.}
	Point result = new Point
	result.X = value.X + other.X
	result.Y = value.Y + other.Y
	result.Z = value.Z + other.Z
	return result
EndFunction


Point Function PointSubtraction(Point value, Point other) Global
	{Subtracts a Point structure from a Point structure.}
	Point result = new Point
	result.X = value.X - other.X
	result.Y = value.Y - other.Y
	result.Z = value.Z - other.Z
	return result
EndFunction


Point Function PointMultiply(Point value, float scalar) Global
	{Multiplies the specified Point structure by the specified scalar and returns the result as a Point.}
	Point result = new Point
	result.X = value.X * scalar
	result.Y = value.Y * scalar
	result.Z = value.Z * scalar
	return result
EndFunction


Point Function PointDivision(Point value, float scalar) Global
	{Divides the specified Point structure by the specified scalar and returns the result as a Point.}
	Point result = new Point
	result.X = value.X / scalar
	result.Y = value.Y / scalar
	result.Z = value.Z / scalar
	return result
EndFunction


Point Function PointAbsolute(Point value) Global
	Point result = new Point
	result.X = Math.Abs(value.X)
	result.Y = Math.Abs(value.Y)
	result.Z = Math.Abs(value.Z)
	return result
EndFunction


; References
;---------------------------------------------

Point Function ToPoint(ObjectReference reference) Global
	Point result = new Point
	If (reference)
		result.X = reference.X
		result.Y = reference.Y
		result.Z = reference.Z
	EndIf
	return result
EndFunction


Function SetPoint(ObjectReference reference, Point value) Global
	If (reference)
		reference.SetPosition(value.X, value.Y, value.Z)
	EndIf
EndFunction
