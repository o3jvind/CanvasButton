#tag Class
Protected Class cCanvasButton
Inherits Canvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  If Me.Active Then
		    If Me.Down Then Me.Status = IconStatus.Down
		    If Me.DownToggled Then Me.Status = IconStatus.DownToggled
		    If Not Me.Down And Not Me.DownToggled Then Me.Status = IconStatus.Normal
		  Else
		    If Me.Down Then Me.Status = IconStatus.Down
		    If Not Me.Down Then Me.Status = IconStatus.Normal
		  End if
		  
		  
		  Me.Invalidate
		  //Pass it to the MouseUp event
		  Return True
		  
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  //Don't do anything if not enabled
		  If Me.Enabled = False Then
		    Return
		  End if
		  
		  If Me.Active Then
		    If Me.Hover Then Me.Status = IconStatus.Hover
		    If Me.HoverToggled Then Me.Status = IconStatus.HoverToggled
		    If Not Me.Hover And Not Me.HoverToggled Then Me.Status = IconStatus.Normal
		  Else
		    If Me.Hover Then Me.Status = IconStatus.Hover
		    If Not Me.Hover Then Me.Status = IconStatus.Normal
		  End If
		  
		  //Store the cursor for Exit
		  Me.AppCursor = App.MouseCursor
		  
		  //And change to hover
		  Me.MouseCursor = Me.HoverCursor
		  
		  Me.Invalidate
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  If Me.Active = True And Me.Toggled Then
		    Me.Status = IconStatus.Toggled
		  Else
		    Me.Status = IconStatus.Normal
		  End if
		  
		  Me.Invalidate
		  
		  Me.MouseCursor = Me.AppCursor
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If X > 0 And X < Self.Width And Y > 0 And Y < Self.Height Then
		    
		    If Me.ButtonStyle <> 0 Then
		      Me.Active = Not Me.Active
		    End If
		    
		    //If the ButtonStyle has been changed to "sticky" during runtime it needs to be disabled
		    If Me.ButtonStyle = 2 Then
		      Me.Enabled = False
		    End if
		    
		    If Me.Active Then
		      If Me.Hover Then Me.Status = IconStatus.Hover
		      If Me.HoverToggled Then Me.Status = IconStatus.HoverToggled
		      If Not Me.Hover And Not Me.HoverToggled Then Me.Status = IconStatus.Normal
		    Else
		      If Me.Hover Then Me.Status = IconStatus.Hover
		      If Not Me.Hover Then Me.Status = IconStatus.Normal
		    End if
		    
		    Me.Invalidate
		    
		    RaiseEvent Action
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  // Set the status
		  If Me.Active Then
		    If me.Toggled Then Me.Status = IconStatus.Toggled
		  Else
		    Me.Status = IconStatus.Normal
		  End if
		  
		  //Set the cursor for Hover
		  Me.HoverCursor = Me.GetCursor(Me.Cursor)
		  
		  RaiseEvent Open
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  Var p As Picture
		  
		  Select Case Status
		    
		  Case IconStatus.Normal
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeNormalPicture, Me.NormalMask, DarkModeNormalColor)
		    Else
		      p = Me.CreatePicture(Me.NormalPicture, Me.NormalMask, NormalColor)
		    End If
		    
		  Case IconStatus.Hover
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeHoverPicture, Me.HoverMask, Me.DarkModeHoverColor)
		    Else
		      p = Me.CreatePicture(Me.HoverPicture, Me.HoverMask, Me.HoverColor)
		    End if
		    
		  Case IconStatus.Down
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeDownPicture, Me.DownMask, Me.DarkModeDownColor)
		    Else
		      p = Me.CreatePicture(Me.DownPicture, Me.DownMask, Me.DownColor)
		    End if
		    
		  Case IconStatus.Toggled
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeToggledPicture, Me.ToggledMask, Me.DarkModeToggledColor)
		    Else
		      p = Me.CreatePicture(Me.ToggledPicture, Me.ToggledMask, Me.ToggledColor)
		    End if
		    
		  Case IconStatus.HoverToggled
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeHoverToggledPicture, Me.HoverToggledMask, Me.DarkModeHoverToggledColor)
		    Else
		      p = Me.CreatePicture(Me.HoverToggledPicture, Me.HoverToggledMask, Me.HoverToggledColor)
		    End if
		    
		  Case IconStatus.DownToggled
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeDownToggledPicture, Me.DownToggledMask, Me.DarkModeDownToggledColor)
		    Else
		      p = Me.CreatePicture(Me.DownToggledPicture, Me.DownToggledMask, Me.DownToggledColor)
		    End if
		    
		  End Select
		  
		  
		  g.DrawPicture(p, 0, 0)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CreatePicture(p As Picture, mp As Picture, c As Color) As Picture
		  Var OutP As New Picture(Me.Width, Me.Height)
		  
		  //Fil the picture with the selected color
		  OutP.Graphics.DrawingColor = c
		  OutP.Graphics.FillRoundRectangle(0, 0, OutP.Graphics.Width, OutP.Graphics.Height, Me.ArcWidth, Me.ArcHeight)
		  
		  //Resize the picure to fit and draw it to the canvas
		  If p <> NIL Then
		    OutP.Graphics.DrawPicture(p, 0, 0, OutP.Graphics.Width, OutP.Graphics.Height, 0, 0, p.Width, p.Height)
		  End if
		  
		  //Resize the mask picure to fit and draw it to the canvas
		  If mp <> NIL Then
		    //Create a new picture to draw the mask in the correct dimensions
		    Var mpOut As New Picture(Me.Width, Me.Height, 32)
		    mpOut.Graphics.DrawPicture(mp, 0, 0, mpOut.Graphics.Width, mpOut.Height, 0, 0, mp.Width, mp.Height)
		    OutP.ApplyMask(mpOut)
		  End if
		  
		  Return OutP
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCursor(i As Integer) As MouseCursor
		  Select Case i
		  Case 0
		    Return System.Cursors.StandardPointer
		  Case 1
		    Return System.Cursors.ArrowAllDirections
		  Case 2
		    Return System.Cursors.ArrowEastWest
		  Case 3
		    Return System.Cursors.ArrowNortheastSouthwest
		  Case 4
		    Return System.Cursors.ArrowNorthSouth
		  Case 5
		    Return System.Cursors.ArrowNorthwestSoutheast
		  Case 6
		    Return System.Cursors.Copy
		  Case 7
		    Return System.Cursors.FingerPointer
		  Case 8
		    Return System.Cursors.HandClosed
		  Case 9
		    Return System.Cursors.HandOpen
		  Case 10
		    Return System.Cursors.IBeam
		  Case 11
		    Return System.Cursors.InvisibleCursor
		  Case 12
		    Return System.Cursors.MagnifyLarger
		  Case 13
		    Return System.Cursors.MagnifySmaller
		  Case 14
		    Return System.Cursors.SplitterEastWest
		  Case 15
		    Return System.Cursors.SplitterNorthSouth
		  Case 16
		    Return System.Cursors.StandardPointer
		  Case 17
		    Return System.Cursors.Wait
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h0
		Active As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		AppCursor As MouseCursor
	#tag EndProperty

	#tag Property, Flags = &h0
		ArcHeight As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		ArcWidth As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		ButtonStyle As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Cursor As Integer = 7
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkmodeHoverToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeNormalColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeNormalPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Down As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		DownColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DownMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DownPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DownToggled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		DownToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DownToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DownToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Hover As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverCursor As MouseCursor
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverToggled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		NormalColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		NormalMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		NormalPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As IconStatus = IconStatus.Normal
	#tag EndProperty

	#tag Property, Flags = &h0
		Toggled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		ToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		ToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		ToggledPicture As Picture
	#tag EndProperty


	#tag Enum, Name = IconStatus, Type = Integer, Flags = &h0
		Normal
		  Hover
		  Down
		  Toggled
		  HoverToggled
		DownToggled
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ArcWidth"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ArcHeight"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Status"
			Visible=false
			Group="Appearance"
			InitialValue="Normal"
			Type="IconStatus"
			EditorType="Enum"
			#tag EnumValues
				"0 - Normal"
				"1 - Hover"
				"2 - Down"
				"3 - Toggled"
				"4 - HoverToggled"
				"5 - DownToggled"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonStyle"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - PushButton"
				"1 - ToggleButton"
				"2 - StickyButton"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Cursor"
			Visible=true
			Group="Behavior"
			InitialValue="7"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - StandardPointer"
				"1 - ArrowAllDirections"
				"2 - ArrowEastWest"
				"3 - ArrowNortheastSouthwest"
				"4 - ArrowNorthSouth"
				"5 - ArrowNorthwestSoutheast"
				"6 - Copy"
				"7 - FingerPointer"
				"8 - HandClosed"
				"9 - HandOpen"
				"10 - IBeam"
				"11 - InvisibleCursor"
				"12 - MagnifyLarger"
				"13 - MagnifySmaller"
				"14 - SplitterEastWest"
				"15 - SplitterNorthSouth"
				"16 - StandardPointer"
				"17 - Wait"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hover"
			Visible=true
			Group="Which Statuses"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Down"
			Visible=true
			Group="Which Statuses"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Toggled"
			Visible=true
			Group="Which Statuses"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverToggled"
			Visible=true
			Group="Which Statuses"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownToggled"
			Visible=true
			Group="Which Statuses"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Active"
			Visible=true
			Group="Initial State"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownToggledColor"
			Visible=true
			Group="Down Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownToggledColor"
			Visible=true
			Group="Down Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownToggledPicture"
			Visible=true
			Group="Down Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownToggledPicture"
			Visible=true
			Group="Down Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownToggledMask"
			Visible=true
			Group="Down Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NormalColor"
			Visible=true
			Group="Normal"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeNormalColor"
			Visible=true
			Group="Normal"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NormalPicture"
			Visible=true
			Group="Normal"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeNormalPicture"
			Visible=true
			Group="Normal"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NormalMask"
			Visible=true
			Group="Normal"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverColor"
			Visible=true
			Group="Mouse Hover"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeHoverColor"
			Visible=true
			Group="Mouse Hover"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverPicture"
			Visible=true
			Group="Mouse Hover"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeHoverPicture"
			Visible=true
			Group="Mouse Hover"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverMask"
			Visible=true
			Group="Mouse Hover"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownColor"
			Visible=true
			Group="Mouse Down"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownColor"
			Visible=true
			Group="Mouse Down"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownPicture"
			Visible=true
			Group="Mouse Down"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownPicture"
			Visible=true
			Group="Mouse Down"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownMask"
			Visible=true
			Group="Mouse Down"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToggledColor"
			Visible=true
			Group="Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeToggledColor"
			Visible=true
			Group="Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToggledPicture"
			Visible=true
			Group="Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeToggledPicture"
			Visible=true
			Group="Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToggledMask"
			Visible=true
			Group="Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverToggledColor"
			Visible=true
			Group="Hover Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeHoverToggledColor"
			Visible=true
			Group="Hover Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverToggledPicture"
			Visible=true
			Group="Hover Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkmodeHoverToggledPicture"
			Visible=true
			Group="Hover Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverToggledMask"
			Visible=true
			Group="Hover Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=false
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group=""
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
