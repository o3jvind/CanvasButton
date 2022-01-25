#tag Class
Protected Class aColorPicker
Inherits DesktopColorPicker
	#tag Event
		Sub Closed()
		  Me.WhatToChange = ""
		  MainWindow.ButtonModePopupMenu.SelectedRowIndex = 0
		End Sub
	#tag EndEvent

	#tag Event
		Sub ColorSelected(selectedColor As Color)
		  Var TheProperties() As Introspection.PropertyInfo = Introspection.GetType(MainWindow.PreviewCCBtn).GetProperties
		  Var Prop As introspection.PropertyInfo
		  
		  Select Case Me.WhatToChange
		    
		  Case "Background"
		    
		    Var ColorProp As String = MainWindow.ButtonModePopupMenu.RowTagAt(MainWindow.ButtonModePopupMenu.SelectedRowIndex) + "Color"
		    
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      If TheProperties(i).Name = ColorProp Then //found the property to change
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.ComposePic()
		      End if
		    Next
		    
		  Case "Mask"
		    
		    Var ColorProp As String = MainWindow.ButtonModePopupMenu.RowTagAt(MainWindow.ButtonModePopupMenu.SelectedRowIndex) + "MaskColor"
		    
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      If TheProperties(i).Name = ColorProp Then //found the property to change
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.ComposePic()
		      End if
		    Next
		    
		  Case "LightModeDisabledOverlayColor"
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      If TheProperties(i).Name = "LightModeDisabledOverlayColor" Then 
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.ComposePic()
		      End if
		    Next
		    
		    
		  Case "DarkModeDisabledOverlayColor"
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      If TheProperties(i).Name = "DarkModeDisabledOverlayColor" Then
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.ComposePic()
		      End if
		    Next
		    
		    
		  Case "LightModeDisabledMaskColor"
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      If TheProperties(i).Name = "LightModeDisabledMaskColor" Then 
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.ComposePic()
		      End if
		    Next
		    
		    
		  Case "DarkModeDisabledMaskColor"
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      If TheProperties(i).Name = "DarkModeDisabledMaskColor" Then
		        
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.ComposePic()
		      End if
		    Next
		    
		  End Select
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		WhatToChange As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasAlpha"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WhatToChange"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
