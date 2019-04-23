package ui

import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ui.filtroYTransformerDate.DateBox
import ui.filtroYTransformerDate.LocalDateTransformer
import viewModel.ConsultarOrdenModel
import viewModel.CrearOrdenModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.Dialog
import java.time.format.DateTimeFormatter
import java.time.LocalDate

class ConsultarOrdenDeCompraWindow extends SimpleWindow<ConsultarOrdenModel> {

	new(WindowOwner parent, ConsultarOrdenModel model) {
		super(parent, model)
		title = defaultTitle
		modelObject.search()
	}

	def defaultTitle() {
		"Consultar Ordenes de Compra"
	}

	override protected addActions(Panel actionsPanel) {
	}

	override protected createFormPanel(Panel panel) {
		val panelHorizontalTextBox = new Panel(panel).layout = new ColumnLayout(3)
		crearTextBox(panelHorizontalTextBox)

		val panelVertical = new Panel(panel).layout = new VerticalLayout

		botonBuscar(panelVertical)
		crearTabla(panelVertical)
		botonOrdenDeCompra(panelVertical)
	}

	def crearTextBox(Panel panel) {
		new Label(panel).text = "Fecha desde "
		new Label(panel).text = "Fecha hasta "
		new Label(panel).text = "Producto "

		new DateBox(panel) => [
			(value <=> "rangoFechas.fechaDesde").transformer = new LocalDateTransformer
			width = 200
		]
	
		new DateBox(panel) => [
			(value <=> "rangoFechas.fechaHasta").transformer = new LocalDateTransformer
			width = 200
		]

		new Selector<Producto>(panel) => [
			allowNull(true)
			width = 200
			val productos = items <=> "repoProductos.allInstances"
			productos.adaptWith(typeof(Producto), "descripcion")
			value <=> "productoSeleccionado"
		]

		new Label(panel).text = "Costo desde "
		new Label(panel).text = "Costo hasta "
		new Label(panel).text = "Proveedor "

		new NumericField(panel) => [
			value <=> "rangoCostos.costoDesde"
			width = 200
		]
		new NumericField(panel) => [
			value <=> "rangoCostos.costoHasta"
			width = 200
		]
		new Selector<Proveedor>(panel) => [
			width = 200
			allowNull(true)
			val proveedores = items <=> "repoProveedores.allInstances"
			proveedores.adaptWith(typeof(Proveedor), "descripcion")
			value <=> "proveedorSeleccionado"
		]
	}

	def botonBuscar(Panel panel) {
		new Button(panel) => [
			caption = "Buscar"
			onClick([|modelObject.validarOrdenABuscar modelObject.search])
			setAsDefault
		]
	}

	def protected crearTabla(Panel panel) {
		val tablaAcciones = new Table<OrdenCompra>(panel, typeof(OrdenCompra)) => [
			items <=> "resultados"
			numberVisibleRows = 10
		]
		this.crearColumnasTabla(tablaAcciones)

	}

	def void crearColumnasTabla(Table<OrdenCompra> table) {
		new Column<OrdenCompra>(table) => [
			title = "Fecha"
			fixedSize = 200
			bindContentsToProperty("fecha").transformer = [LocalDate fecha | fecha.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))]
		]

		new Column<OrdenCompra>(table) => [
			title = "Productos"
			fixedSize = 300
			alignRight
			bindContentsToProperty("listaDescripciones")
		]

		new Column<OrdenCompra>(table) => [
			title = "Proveedor"
			fixedSize = 200
			alignRight
			bindContentsToProperty("proveedor.descripcion")
		]
		new Column<OrdenCompra>(table) => [
			title = "Total"
			fixedSize = 200
			alignRight
			bindContentsToProperty("costo")
		]

	}

	def botonOrdenDeCompra(Panel panel) {
		new Button(panel) => [
			caption = "Crear Orden de Compra"
			onClick([|this.crearOrden])
		]
	}

	def void crearOrden() {
		this.openDialog(new CrearOrdenWindow(this, new CrearOrdenModel()))
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.search]
		dialog.open
	}

}
