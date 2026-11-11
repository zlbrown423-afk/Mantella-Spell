Scriptname LWDiary_Book extends ObjectReference
{A Living World diary. Opening it (from a table, a pocket or the player's own inventory) tells LWDiary_Quest,
which asks the Mantella server for the pages and shows them once the book is closed.}

ObjectReference Property Holder Auto Hidden   ; the container it is in (None while it lies in the world)

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	Holder = akNewContainer
EndEvent

Event OnRead()
	Int handle = ModEvent.Create("LivingWorld_DiaryOpened")
	If handle
		ModEvent.PushForm(handle, Self)
		ModEvent.Send(handle)
	EndIf
EndEvent
