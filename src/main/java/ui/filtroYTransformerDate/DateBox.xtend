package ui.filtroYTransformerDate

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox

class DateBox extends TextBox {
	
	new(Panel container) {
		super(container)
	}
	
	override bindValueToProperty(String propertyName) {
		val binding = super.bindValueToProperty(propertyName)
		this.withFilter(new DateTextFilter)
		binding
	}
	
}