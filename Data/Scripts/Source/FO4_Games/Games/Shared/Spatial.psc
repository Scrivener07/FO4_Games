Scriptname Games:Shared:Spatial Const Native Hidden
import Games:Shared:PointType


; References
;---------------------------------------------

Point Function ToPosition(ObjectReference reference) Global
	Point result = new Point
	If (reference)
		result.X = reference.X
		result.Y = reference.Y
		result.Z = reference.Z
	EndIf
	return result
EndFunction


Point Function ToAngle(ObjectReference reference) Global
	Point result = new Point
	If (reference)
		result.X = reference.GetAngleX()
		result.Y = reference.GetAngleY()
		result.Z = reference.GetAngleZ()
	EndIf
	return result
EndFunction


Function SetPoint(ObjectReference reference, Point position, Point angle) Global
	If (reference)
		reference.SetPosition(position.X, position.Y, position.Z)
		reference.SetAngle(angle.X, angle.Y, angle.Z)
	EndIf
EndFunction
