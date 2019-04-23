package ui

import domain.Producto
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import domain.ItemProducto

class DetalleProductoCompuestoWindow extends DetalleProductoWindow {

	new(WindowOwner parent, Producto model) {
		super(parent, model)
	}

	override crearDatosEspecificos(Panel panel) {
		crearTabla(panel)
	}

	def crearTabla(Panel panel) {
		val tablaAcciones = new Table<ItemProducto>(panel, typeof(ItemProducto)) => [
			items <=> "productoSeleccionado.listaDeProductos"
			numberVisibleRows = 10
		]
		this.crearColumnasTabla(tablaAcciones)
	}

	def void crearColumnasTabla(Table<ItemProducto> table) {

		new Column<ItemProducto>(table) => [
			title = "Cantidad"
			fixedSize = 100
			alignRight
			bindContentsToProperty("cantidad")
		]

		new Column<ItemProducto>(table) => [
			title = "Producto"
			fixedSize = 200
			bindContentsToProperty("producto.descripcion")
		]
	}
}
