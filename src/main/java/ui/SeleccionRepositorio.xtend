package ui

import org.uqbar.arena.windows.SimpleWindow
import viewModel.ConsultarStockModel
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

class SeleccionRepositorio extends SimpleWindow<ConsultarStockModel> {

	new(WindowOwner parent, ConsultarStockModel model) {
		super(parent, model)
		title = "Seleccionar persistencia"
		modelObject.search()
	}
	
	
	
	override protected addActions(Panel actionsPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override protected createFormPanel(Panel mainPanel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	
}