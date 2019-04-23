package ui

import domain.Producto
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.WindowOwner
import viewModel.DetalleProductokModel

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class DetalleProductoWindow extends TransactionalDialog<DetalleProductokModel> {

	new(WindowOwner parent, Producto model) {
		super(parent, new DetalleProductokModel(model))
		title = defaultTitle
	}

	def defaultTitle() {
		"Detalle stock productos"
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Volver a Consulta"
			onClick([|this.accept])
		]
	}

	override protected createFormPanel(Panel mainPanel) {
		crearDescripcionYTextBox(mainPanel)
		detalleProducto(mainPanel)
		crearLabelVentaNumericFieldYBoton(mainPanel)
	}

	def crearLabelVentaNumericFieldYBoton(Panel panel) {
		crearLabel(panel, "Cantidad a Vender:")
		crearNumericFieldYBotonVenta(panel)
	}

	def detalleProducto(Panel panel) {
		crearDatosEspecificos(panel)
		crearDatosGenerales(panel)
	}

	def void crearDatosEspecificos(Panel panel) {
		// NO HAY DATOS ESPECIFICOS EN ESTA CLASE
	}

	def crearNumericFieldYBotonVenta(Panel panel) {
		val panelHorizontal = new Panel(panel) => [
			layout = new HorizontalLayout

		]
		new NumericField(panelHorizontal, false) => [
			value <=> "cantidadAVender"
			width = 150
		]
		new Button(panelHorizontal) => [
			caption = "Realizar Venta"
			onClick([|modelObject.vender()])
			bindEnabledToProperty("habilitarVenta")
		]
	}

	def Label crearDatosGenerales(Panel mainPanel) {
		val panelCuatroColumnas = new Panel(mainPanel).layout = new ColumnLayout(4)
		crearLabelsDescripciones(panelCuatroColumnas, "Stock Actual", "Stock Mínimo", "Stock Máximo", "Costo")
		crearLabelsAPropiedades(panelCuatroColumnas, "productoSeleccionado.stockAct", "productoSeleccionado.stockMin",
			"productoSeleccionado.stockMax", "productoSeleccionado.costo")
	}

	def TextBox crearDescripcionYTextBox(Panel mainPanel) {
		val panelDescripcionYTextBox = new Panel(mainPanel)
		crearLabel(panelDescripcionYTextBox, "Descripción")

		new TextBox(panelDescripcionYTextBox) => [
			value <=> "productoSeleccionado.descripcion"
			width = 200
		]
	}

	def TextBox crearLabelVentaYTextBox(Panel mainPanel) {
		val panelDescripcionYTextBox = new Panel(mainPanel)
		crearLabel(panelDescripcionYTextBox, "Descripción")

		new TextBox(panelDescripcionYTextBox) => [
			value <=> "productoSeleccionado.descripcion"
			width = 200
		]
	}

	def crearLabelsDescripciones(Panel panel, String descripcion1, String descripcion2, String descripcion3,
		String descripcion4) {

		crearLabel(panel, descripcion1)
		crearLabel(panel, descripcion2)
		crearLabel(panel, descripcion3)
		crearLabel(panel, descripcion4)
	}

	def crearLabel(Panel panel, String descripcion) {
		new Label(panel) => [
			text = descripcion
			alignLeft
			width = 200
		]
	}

	def crearLabelsAPropiedades(Panel panel, String propiedad1, String propiedad2, String propiedad3,
		String propiedad4) {

		crearLabelDeUnaPropiedad(panel, propiedad1)
		crearLabelDeUnaPropiedad(panel, propiedad2)
		crearLabelDeUnaPropiedad(panel, propiedad3)
		crearLabelDeUnaPropiedad(panel, propiedad4)
	}

	def crearLabelDeUnaPropiedad(Panel panel, String propiedad) {
		new Label(panel) => [
			value <=> propiedad
			alignLeft
			width = 200
		]
	}

}
