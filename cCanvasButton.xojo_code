#tag Class
Protected Class cCanvasButton
Inherits DesktopCanvas
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  //Check "Active" status
		  If Me.Active Then
		    If Me.DownToggled Then Me.Status = IconStatus.DownToggled
		  Else
		    If Me.Down Then Me.Status = IconStatus.Down
		  End if
		  
		  //Change to cursor to down cursor
		  Me.MouseCursor = Me.DCursor
		  ComposePic()
		  
		  
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
		  
		  //Check "Active" status
		  If Me.Active Then
		    If Me.HoverToggled Then Me.Status = IconStatus.HoverToggled
		  Else
		    If Me.Hover Then Me.Status = IconStatus.Hover
		  End If
		  
		  //Store the cursor for Exit
		  Me.AppCursor = App.MouseCursor
		  
		  //And change mouse to hover
		  Me.MouseCursor = Me.HCursor
		  ComposePic()
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  //Check "Active" status
		  If Me.Active = True And Me.Toggled Then
		    Me.Status = IconStatus.Toggled
		  Else
		    Me.Status = IconStatus.Normal
		  End if
		  ComposePic()
		  
		  
		  //Restore Cursor to the saved cursor on enter
		  Me.MouseCursor = Me.AppCursor
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  If X > 0 And X < Self.Width And Y > 0 And Y < Self.Height Then
		    
		    //Check if the is a toggle or sticky button and switch status
		    If Me.ButtonStyle <> 0 Then
		      Me.Active = Not Me.Active
		    End If
		    
		    //If the ButtonStyle has been changed to "sticky" during runtime it needs to be disabled on MouseUp
		    If Me.ButtonStyle = 2 Then
		      Me.Enabled = False
		    End if
		    
		    //Set  the icon status
		    If Me.Active Then
		      If Me.Hover Then Me.Status = IconStatus.Hover
		      If Me.HoverToggled Then Me.Status = IconStatus.HoverToggled
		    Else
		      If Me.Hover Then Me.Status = IconStatus.Hover
		      If Not Me.Hover Then Me.Status = IconStatus.Normal
		    End if
		    
		    //And change mouse to hover
		    Me.MouseCursor = Me.HCursor
		    ComposePic()
		    
		    
		    
		    
		    RaiseEvent Action
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  // Set the status
		  If Me.Active Then
		    If me.Toggled Then Me.Status = IconStatus.Toggled
		  Else
		    Me.Status = IconStatus.Normal
		  End if
		  
		  //Set the cursor for Hover & Down
		  Me.HCursor = Me.GetCursor(Me.HoverCursor)
		  Me.DCursor = Me.GetCursor(Me.DownCursor)
		  ComposePic()
		  
		  RaiseEvent Opening
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  g.DrawPicture(Me.CurrentPic, 0, 0)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub ComposePic()
		  Var p As Picture
		  
		  Select Case Status
		    
		  Case IconStatus.Normal
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeNormalPicture, Me.DarkModeNormalMask, Me.DarkModeNormalColor, DarkModeNormalMaskColor)
		    Else
		      p = Me.CreatePicture(Me.LightModeNormalPicture, Me.LightModeNormalMask, Me.LightModeNormalColor, LightModeNormalMaskColor)
		    End If
		    
		  Case IconStatus.Hover
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeHoverPicture, Me.DarkModeHoverMask, Me.DarkModeHoverColor, Me.DarkModeHoverMaskColor)
		    Else
		      p = Me.CreatePicture(Me.LightModeHoverPicture, Me.LightModeHoverMask, Me.LightModeHoverColor, Me.LightModeHoverMaskColor)
		    End if
		    
		  Case IconStatus.Down
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeDownPicture, Me.DarkModeDownMask, Me.DarkModeDownColor, Me.DarkModeDownMaskColor)
		    Else
		      p = Me.CreatePicture(Me.LightModeDownPicture, Me.LightModeDownMask, Me.LightModeDownColor, Me.LightModeDownMaskColor)
		    End if
		    
		  Case IconStatus.Toggled
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeToggledPicture, Me.DarkModeToggledMask, Me.DarkModeToggledColor, Me.DarkModeToggledMaskColor)
		    Else
		      p = Me.CreatePicture(Me.LightModeToggledPicture, Me.LightModeToggledMask, Me.LightModeToggledColor, Me.LightModeToggledMaskColor)
		    End if
		    
		  Case IconStatus.HoverToggled
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeHoverToggledPicture, Me.DarkModeHoverToggledMask, Me.DarkModeHoverToggledColor, Me.DarkModeHoverToggledMaskColor)
		    Else
		      p = Me.CreatePicture(Me.LightModeHoverToggledPicture, Me.LightModeHoverToggledMask, Me.LightModeHoverToggledColor, Me.LightModeHoverToggledMaskColor)
		    End if
		    
		  Case IconStatus.DownToggled
		    If Color.IsDarkMode Then
		      p = Me.CreatePicture(Me.DarkModeDownToggledPicture, Me.DarkModeDownToggledMask, Me.DarkModeDownToggledColor, Me.DarkModeDownToggledMaskColor)
		    Else
		      p = Me.CreatePicture(Me.LightModeDownToggledPicture, Me.LightModeDownToggledMask, Me.LightModeDownToggledColor, Me.LightModeDownToggledMaskColor)
		    End if
		    
		  End Select
		  
		  
		  Me.CurrentPic = CreateImageSet(p)
		  Me.Refresh(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreateImageSet(InPic As Picture) As Picture
		  //Create two pictures with the content of the inPic
		  Var SmallPic As New Picture(InPic.Width / 2, InPic.Height / 2)
		  SmallPic.Graphics.DrawPicture(InPic, 0, 0, InPic.Width / 2, InPic.Height / 2, 0, 0, InPic.Width, InPic.Height)
		  
		  Var BigPic As New Picture(InPic.Width, InPic.Height)
		  BigPic.Graphics.DrawPicture(InPic, 0, 0, InPic.Width, InPic.Height, 0, 0, InPic.Width, InPic.Height)
		  
		  //Create an array with the pics
		  Var BitMaps() As Picture
		  BitMaps.Append(SmallPic)
		  BitMaps.Append(BigPic)
		  
		  //Create a picture(set) with the pictures and return it
		  Var PicSet As New Picture(InPic.Width / 2, InPic.Height / 2, BitMaps())
		  
		  Return PicSet
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatePicture(p As Picture, mp As Picture, c As Color, mc As Color) As Picture
		  Var OutP As New Picture(Me.Width * 2, Me.Height * 2, 32)
		  Var mpOut As New Picture(Me.Width *2, Me.Height * 2, 32)
		  
		  //Fil the picture with the selected color
		  OutP.Graphics.DrawingColor = c
		  OutP.Graphics.FillRoundRectangle(0, 0, OutP.Graphics.Width, OutP.Graphics.Height, Me.ArcWidth, Me.ArcHeight)
		  
		  //Resize the picure to fit and draw it to the canvas
		  If p <> NIL Then
		    OutP.Graphics.DrawPicture(p, 0, 0, OutP.Graphics.Width, OutP.Graphics.Height, 0, 0, p.Width, p.Height)
		  End if
		  
		  //Fill the mask picture with the mask color
		  mpOut.Graphics.DrawingColor = mc
		  mpOut.Graphics.FillRoundRectangle(0, 0, mpOut.Width, mpOut.height, Me.ArcWidth, Me.ArcHeight)
		  
		  //If set, resize a mask picure to fit and draw it to the mask picture graphics
		  If mp <> NIL Then
		    //Create a new picture to draw the mask in the correct dimensions
		    mpOut.Graphics.DrawPicture(mp, 0, 0, mpOut.Graphics.Width, mpOut.Height, 0, 0, mp.Width, mp.Height)
		  End if
		  
		  If Me.Enabled = False Then
		    Var DmpOut As New Picture(Me.Width *2, Me.Height * 2, 32)
		    If Color.IsDarkMode Then
		      outP.Graphics.DrawingColor = DarkModeDisabledOverlayColor
		      DmpOut.Graphics.DrawingColor = DarkModeDisabledMaskColor
		      DmpOut.Graphics.FillRoundRectangle(0, 0, DmpOut.Graphics.Width, DmpOut.Graphics.Height, Me.ArcWidth, Me.ArcHeight)
		    Else
		      outP.Graphics.DrawingColor = LightModeDisabledOverlayColor
		      DmpOut.Graphics.DrawingColor = LightModeDisabledMaskColor
		      DmpOut.Graphics.FillRoundRectangle(0, 0, DmpOut.Graphics.Width, DmpOut.Graphics.Height, Me.ArcWidth, Me.ArcHeight)
		    End if
		    mpOut.ApplyMask(DmpOut)
		    outP.Graphics.FillRoundRectangle(0, 0, outP.Graphics.Width, outP.Graphics.Height, Me.ArcWidth, Me.ArcHeight)
		  End if
		  
		  OutP.ApplyMask(mpOut)
		  Return OutP
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCursor(i As Integer) As MouseCursor
		  Select Case i
		  Case 0
		    Return System.Cursors.ArrowAllDirections
		  Case 1
		    Return System.Cursors.ArrowEastWest
		  Case 2
		    Return System.Cursors.ArrowNortheastSouthwest
		  Case 3
		    Return System.Cursors.ArrowNorthSouth
		  Case 4
		    Return System.Cursors.ArrowNorthwestSoutheast
		  Case 5
		    Return System.Cursors.Copy
		  Case 6
		    Return System.Cursors.FingerPointer
		  Case 7
		    Return System.Cursors.HandClosed
		  Case 8
		    Return System.Cursors.HandOpen
		  Case 9
		    Return System.Cursors.IBeam
		  Case 10
		    Return System.Cursors.InvisibleCursor
		  Case 11
		    Return System.Cursors.MagnifyLarger
		  Case 12
		    Return System.Cursors.MagnifySmaller
		  Case 13
		    Return System.Cursors.SplitterEastWest
		  Case 14
		    Return System.Cursors.SplitterNorthSouth
		  Case 15
		    Return System.Cursors.StandardPointer
		  Case 16
		    Return System.Cursors.Wait
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Action()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
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
		CurrentPic As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDisabledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDisabledOverlayColor As Color = &cFFFFFF88
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownToggledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeDownToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkmodeHoverToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeHoverToggledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkmodeHoverToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeNormalColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeNormalMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeNormalMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeNormalPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeToggledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DarkModeToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		DCursor As MouseCursor
	#tag EndProperty

	#tag Property, Flags = &h0
		Down As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		DownCursor As Integer = 6
	#tag EndProperty

	#tag Property, Flags = &h0
		DownToggled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		HCursor As MouseCursor
	#tag EndProperty

	#tag Property, Flags = &h0
		Hover As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverCursor As Integer = 6
	#tag EndProperty

	#tag Property, Flags = &h0
		HoverToggled As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDisabledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDisabledOverlayColor As Color = &cFFFFFF88
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownToggledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeDownToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverToggledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeHoverToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeNormalColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeNormalMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeNormalMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeNormalPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeToggledColor As Color = &c000000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeToggledMask As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeToggledMaskColor As Color = &c00000000
	#tag EndProperty

	#tag Property, Flags = &h0
		LightModeToggledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		Status As IconStatus = IconStatus.Normal
	#tag EndProperty

	#tag Property, Flags = &h0
		Toggled As Boolean = True
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
			Name="Active"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonStyle"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Push Button"
				"1 - Toggle Button"
				"2 - Sticky Button"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverCursor"
			Visible=true
			Group="Behavior"
			InitialValue="6"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Arrow All Directions"
				"1 - Arrow East West"
				"2 - Arrow Northeast Southwest"
				"3 - Arrow North South"
				"4 - Arrow Northwest Southeast"
				"5 - Copy"
				"6 - Finger Pointer"
				"7 - Hand Closed"
				"8 - Hand Open"
				"9 - IBeam"
				"10 - Invisible Cursor"
				"11 - Magnify Larger"
				"12 - Magnify Smaller"
				"13 - Splitter EastWest"
				"14 - Splitter NorthSouth"
				"15 - Standard Pointer"
				"16 - Wait"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownCursor"
			Visible=true
			Group="Behavior"
			InitialValue="6"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Arrow All Directions"
				"1 - Arrow East West"
				"2 - Arrow Northeast Southwest"
				"3 - Arrow North South"
				"4 - Arrow Northwest Southeast"
				"5 - Copy"
				"6 - Finger Pointer"
				"7 - Hand Closed"
				"8 - Hand Open"
				"9 - IBeam"
				"10 - Invisible Cursor"
				"11 - Magnify Larger"
				"12 - Magnify Smaller"
				"13 - Splitter EastWest"
				"14 - Splitter NorthSouth"
				"15 - Standard Pointer"
				"16 - Wait"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ArcHeight"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ArcWidth"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hover"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Down"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Toggled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverToggled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DownToggled"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Status"
			Visible=false
			Group="Behavior"
			InitialValue="IconStatus.Normal"
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
			Name="LightModeDisabledOverlayColor"
			Visible=true
			Group="Disabled Overlay Color"
			InitialValue="&cFFFFFF88"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDisabledOverlayColor"
			Visible=true
			Group="Disabled Overlay Color"
			InitialValue="&cFFFFFF88"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDisabledMaskColor"
			Visible=true
			Group="Disabled Overlay Color"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDisabledMaskColor"
			Visible=true
			Group="Disabled Overlay Color"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeNormalColor"
			Visible=true
			Group="Normal"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeNormalMaskColor"
			Visible=true
			Group="Normal"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeNormalPicture"
			Visible=true
			Group="Normal"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeNormalMask"
			Visible=true
			Group="Normal"
			InitialValue=""
			Type="Picture"
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
			Name="DarkModeNormalMaskColor"
			Visible=true
			Group="Normal"
			InitialValue="&c00000000"
			Type="Color"
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
			Name="DarkModeNormalMask"
			Visible=true
			Group="Normal"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverColor"
			Visible=true
			Group="Hover"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverMaskColor"
			Visible=true
			Group="Hover"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverPicture"
			Visible=true
			Group="Hover"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverMask"
			Visible=true
			Group="Hover"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeHoverColor"
			Visible=true
			Group="Hover"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeHoverMaskColor"
			Visible=true
			Group="Hover"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeHoverPicture"
			Visible=true
			Group="Hover"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeHoverMask"
			Visible=true
			Group="Hover"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownColor"
			Visible=true
			Group="Down"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownMaskColor"
			Visible=true
			Group="Down"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownPicture"
			Visible=true
			Group="Down"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownMask"
			Visible=true
			Group="Down"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownColor"
			Visible=true
			Group="Down"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownMaskColor"
			Visible=true
			Group="Down"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownPicture"
			Visible=true
			Group="Down"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkModeDownMask"
			Visible=true
			Group="Down"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeToggledColor"
			Visible=true
			Group="Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeToggledMaskColor"
			Visible=true
			Group="Toggled"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeToggledPicture"
			Visible=true
			Group="Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeToggledMask"
			Visible=true
			Group="Toggled"
			InitialValue=""
			Type="Picture"
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
			Name="DarkModeToggledMaskColor"
			Visible=true
			Group="Toggled"
			InitialValue="&c00000000"
			Type="Color"
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
			Name="DarkModeToggledMask"
			Visible=true
			Group="Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverToggledColor"
			Visible=true
			Group="Hover Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverToggledMaskColor"
			Visible=true
			Group="Hover Toggled"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverToggledPicture"
			Visible=true
			Group="Hover Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeHoverToggledMask"
			Visible=true
			Group="Hover Toggled"
			InitialValue=""
			Type="Picture"
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
			Name="DarkModeHoverToggledMaskColor"
			Visible=true
			Group="Hover Toggled"
			InitialValue="&c00000000"
			Type="Color"
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
			Name="DarkmodeHoverToggledMask"
			Visible=true
			Group="Hover Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownToggledColor"
			Visible=true
			Group="Down Toggled"
			InitialValue="&c000000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownToggledMaskColor"
			Visible=true
			Group="Down Toggled"
			InitialValue="&c00000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownToggledPicture"
			Visible=true
			Group="Down Toggled"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LightModeDownToggledMask"
			Visible=true
			Group="Down Toggled"
			InitialValue=""
			Type="Picture"
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
			Name="DarkModeDownToggledMaskColor"
			Visible=true
			Group="Down Toggled"
			InitialValue="&c00000000"
			Type="Color"
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
			Name="DarkModeDownToggledMask"
			Visible=true
			Group="Down Toggled"
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
			Name="CurrentPic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
