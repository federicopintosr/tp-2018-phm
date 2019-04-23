package ui

import domain.Producto
import domain.ProductoCompuesto
import java.awt.Color
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import viewModel.ConsultarStockModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class ConsultarStockWindow extends SimpleWindow<ConsultarStockModel> {

	new(WindowOwner parent, ConsultarStockModel model) {
		super(parent, model)
		title = defaultTitle
		modelObject.search()
	}

	def defaultTitle() {
		"Consultar Stock"
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel panel) {
		val panelHorizontalTextBox = new Panel(panel).layout = new ColumnLayout(3)
		crearTextBox(panelHorizontalTextBox)

		val panelHorizontalCheckBox = new Panel(panel).layout = new HorizontalLayout
		checkBox(panelHorizontalCheckBox)
		val panelVertical = new Panel(panel).layout = new VerticalLayout

		botonBuscar(panelVertical)
		crearTabla(panelVertical)
		botonDetalle(panelVertical)
	}

	def crearTextBox(Panel panel) {
		new Label(panel).text = "Descripcion: "
		new Label(panel).text = "Stock mayor a: "
		new Label(panel).text = "Stock menor a: "

		new TextBox(panel) => [
			value <=> "descripcion"
			width = 100
		]

		new NumericField(panel, false) => [
			value <=> "stockMinimoABuscar"
			width = 100
		]

		new NumericField(panel, false) => [
			value <=> "stockMaximoABuscar"
			width = 100
		]
	}

	def checkBox(Panel panel) {
		new CheckBox(panel) => [
			value <=> "soloDebajoStockMinimo"
		]
		new Label(panel).text = "Por debajo del stock minimo: "
	}

	def botonBuscar(Panel panel) {
		new Button(panel) => [
			caption = "Buscar"
			onClick([|modelObject.validarStockABuscar modelObject.search])
			setAsDefault
		]
	}

	def crearTabla(Panel panel) {
		val tablaAcciones = new Table<Producto>(panel, typeof(Producto)) => [
			items <=> "resultados"
			value <=> "productoSeleccionado"
			numberVisibleRows = 10

		]
		this.crearColumnasTabla(tablaAcciones)

	}

	def void crearColumnasTabla(Table<Producto> table) {

		new Column<Producto>(table) => [


			title = "Producto"
			fixedSize = 200
			bindContentsToProperty("descripcion")
			bindForeground("debajoStockMinimo").transformer = 
				[Boolean esBajo|if(esBajo) Color.RED else Color.BLACK]
		]

		new Column<Producto>(table) => [
			title = "Stock actual"
			fixedSize = 200
			alignRight
			bindContentsToProperty("stockAct")
			bindForeground("debajoStockMinimo").transformer = 
				[Boolean esBajo|if(esBajo) Color.RED else Color.BLACK]		]

		new Column<Producto>(table) => [
			title = "Stock minimo"
			fixedSize = 200
			alignRight
			bindContentsToProperty("stockMin")
			bindForeground("debajoStockMinimo").transformer = 
				[Boolean esBajo|if(esBajo) Color.RED else Color.BLACK]
		]
	}

	def botonDetalle(Panel panel) {
		val elementSelected = new NotNullObservable("productoSeleccionado")
		new Button(panel) => [
			caption = "Detalle"
			onClick([|this.detalleStock])
			bindEnabled(elementSelected)
		]
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

	def detalleStock() {
		this.detalleStock(modelObject.productoSeleccionado)
	}

	def dispatch detalleStock(ProductoCompuesto productoCompuesto) {
		this.openDialog(new DetalleProductoCompuestoWindow(this, modelObject.productoCompuestoSeleccionado))
	}

	def dispatch detalleStock(Producto productoSimple) {
		this.openDialog(new DetalleProductoWindow(this, modelObject.productoSeleccionado))
	}

}
