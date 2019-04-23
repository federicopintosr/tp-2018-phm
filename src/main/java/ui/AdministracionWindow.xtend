package ui

import domain.Administracion
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import runnable.ProductosBootstrap
import viewModel.ConfigurarPersistenciaModel
import viewModel.ConsultarOrdenModel
import viewModel.ConsultarStockModel

class AdministracionWindow extends SimpleWindow<Administracion> {

	new(WindowOwner parent) {
		super(parent, new Administracion)
		title = defaultTitle
	}

	def defaultTitle() {
		"Administracion"
	}

	override protected createFormPanel(Panel mainPanel) {
		val panelTablaYBotones = new Panel(mainPanel).layout = new VerticalLayout
		crearBotonera(panelTablaYBotones)

	}

	def void crearBotonera(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Consultar Stock"
			onClick([|this.consultarStock])
		]

		new Button(actionsPanel) => [
			caption = "Consultar Ordenes de Compra"
			onClick([|this.consultarOrdenes])
		]

		new Button(actionsPanel) => [
			caption = "Configuracion de Persistencia"
			onClick([|this.configurarPersistencia])
		]
	}

	override protected addActions(Panel actionsPanel) {
	}

	def void consultarStock() {
		new ConsultarStockWindow(this, new ConsultarStockModel()).open()
	}

	def void consultarOrdenes() {
		new ConsultarOrdenDeCompraWindow(this, new ConsultarOrdenModel()).open()
	}

	def void configurarPersistencia() {
	openDialog(	new ConfiguracionPersistenciaWindow(this, new ConfigurarPersistenciaModel()))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[| 
			ProductosBootstrap.cargarBase
		]
		dialog.open
	}

}
