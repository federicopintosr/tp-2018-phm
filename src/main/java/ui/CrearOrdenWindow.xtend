package ui

import domain.Producto
import domain.Proveedor
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner
import ui.filtroYTransformerDate.DateBox
import ui.filtroYTransformerDate.LocalDateTransformer
import viewModel.CrearOrdenModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class CrearOrdenWindow extends TransactionalDialog<CrearOrdenModel>{
	
	
	new(WindowOwner parent, CrearOrdenModel model) {
		super(parent, model)
		title = defaultTitle
	}
	
		def defaultTitle() {
		"Crear Ordenes de Compra"
	}
	
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Aceptar"
		 	onClick([|this.accept])
		]

		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick([|close])
		]
	}
	
	override protected createFormPanel(Panel panel) {
		val panelHorizontalTextBox2 = new Panel(panel).layout = new HorizontalLayout
		crearTextBoxYSelectorProovedor(panelHorizontalTextBox2)
		val panelHorizontalTextBox1 = new Panel(panel).layout = new HorizontalLayout
		crearTextBoxSelectorYBotonAgregarProducto(panelHorizontalTextBox1)
		val panelVertical = new Panel(panel).layout = new VerticalLayout
		crearTabla(panelVertical)
		botonOrdenDeEliminar(panelVertical)
		labelTotal(panelVertical)
	}
	
	
	def crearTextBoxYSelectorProovedor(Panel panel) {
		new Label(panel).text = "Fecha : "
		new DateBox(panel) => [
			(value <=> "fecha").transformer = new LocalDateTransformer
			width = 200
		]
		
		new Label(panel).text = "Proovedor: "
		new Selector<ConsultarOrdenDeCompraWindow>(panel) => [
			allowNull(false)
			val propiedadAcciones = items <=> "repoProveedores.allInstances"
			propiedadAcciones.adaptWith(typeof(Proveedor), "descripcion")
			value <=> "proveedorSeleccionado"
		]	
	}
	
	def crearTextBoxSelectorYBotonAgregarProducto(Panel panel) {
		new Label(panel).text = "Cantidad : "
		new TextBox(panel) => [
			value <=> "cantidad"
			width = 75
		]
		
		new Label(panel).text = "Producto: "
		new Selector<ConsultarOrdenDeCompraWindow>(panel) => [
			allowNull(false)
			val propiedadAcciones = items <=> "repoProductos.allInstances"
			propiedadAcciones.adaptWith(typeof(Producto), "descripcion")
			value <=> "productoSeleccionado"
		]
		
		new Button(panel) => [
			caption = "Agregar"
			onClick([|modelObject.agregar])
		]	
	}
	
	def protected crearTabla(Panel panel) {
		val tablaAcciones = new Table<Producto>(panel, typeof(Producto)) => [
			items <=> "ordenCompra.listaDeProductos"
			value<=>"item"
			numberVisibleRows = 6
		]
		this.crearColumnasTabla(tablaAcciones)
	}

	def void crearColumnasTabla(Table<Producto> table) {

		new Column<Producto>(table) => [
			title = "Producto"
			fixedSize = 100
			alignRight
			bindContentsToProperty("descripcion")
		]
		
		new Column<Producto>(table) => [
			title = "Total"
			fixedSize = 100
			alignRight
			bindContentsToProperty("costo")
		]
	}

	def botonOrdenDeEliminar(Panel panel){
		new Button(panel) => [
			caption = "Eliminar"
			onClick([|this.eliminarProducto])
			]
	}
	
	
	def eliminarProducto(){	modelObject.eliminar()}	

	def labelTotal(Panel panel){
		new Label(panel).text = "TOTAL: "
		new Label(panel) => [
			value <=> "ordenCompra.costoFinal"
			width = 200
			]
	}
	override accept(){
		modelObject.agregarOrden
		super.accept()
	}
	
}