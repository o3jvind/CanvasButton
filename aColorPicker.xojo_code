#tag Class
Protected Class aColorPicker
Inherits DesktopColorPicker
	#tag Event
		Sub Closed()
		  Me.WhatToChange = ""
		  MainWindow.ColorPropertyPopupMenu.SelectedRowIndex = 0
		End Sub
	#tag EndEvent

	#tag Event
		Sub ColorSelected(selectedColor As Color)
		  Var TheProperties() As Introspection.PropertyInfo = Introspection.GetType(MainWindow.PreviewCCBtn).GetProperties
		  Var Prop As introspection.PropertyInfo
		  
		  
		  
		  If Me.WhatToChange = "Background" Then
		    
		    Var ColorProp As String = MainWindow.ColorPropertyPopupMenu.SelectedRow
		    
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      if TheProperties(i).Name = ColorProp then //found the property to change
		        
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.Invalidate
		        
		      End if
		    Next
		  End if
		  
		  If Me.WhatToChange = "LightModeDisabledOverlayColor" Then
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      if TheProperties(i).Name = "LightModeDisabledOverlayColor" then 
		        
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.Invalidate
		      End if
		    Next
		  End if
		  
		  If Me.WhatToChange = "DarkModeDisabledOverlayColor" Then
		    For i As Integer = 0 to TheProperties().Count - 1
		      
		      if TheProperties(i).Name = "DarkModeDisabledOverlayColor" then 
		        
		        prop = TheProperties(i)
		        prop.Value(MainWindow.PreviewCCBtn) = SelectedColor
		        MainWindow.PreviewCCBtn.Invalidate
		      End if
		    Next
		  End if
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
