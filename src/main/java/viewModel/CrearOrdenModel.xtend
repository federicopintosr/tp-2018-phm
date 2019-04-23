package viewModel

import domain.ItemOrdenCompra
import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProducto
import repositorio.interfaces.RepoProveedor
import repositorio.persistencias.RepoManagerOrdenesDeCompra
import repositorio.persistencias.RepoManagerProductos
import repositorio.persistencias.RepoManagerProveedores

@Accessors
@Observable
class CrearOrdenModel {

	var RepoProveedor repoProveedores = getRepoProveedor
	var RepoProducto repoProductos = getRepoProducto
	var int cantidad
	var Producto producto
	var Producto productoSeleccionado
	var Proveedor proovedor
	var Proveedor proveedorSeleccionado
	var ItemOrdenCompra item
	var OrdenCompra ordenCompra
	var double costoFinal
	LocalDate fecha

	new() {
		ordenCompra = new OrdenCompra
	}
	
		def RepoProducto getRepoProducto() {
		RepoManagerProductos.instance.repoActivo
	}

	
	def RepoProveedor getRepoProveedor() {
		RepoManagerProveedores.instance.repoActivo
	}
	
	def  RepoManagerOrdenesDeCompra getRepoOrdenCompra() {
		RepoManagerOrdenesDeCompra.instance
	}

	def agregar() {
		this.agregarProducto
		this.agregarProveedor
		this.costoTotal
	}

	def agregarProveedor() {
		ordenCompra.setProveedor(proveedorSeleccionado)
	}

	def agregarProducto() {
		val itemAAgregar = new ItemOrdenCompra
		itemAAgregar.setProducto(productoSeleccionado)
		itemAAgregar.setCantidad(cantidad)
		ordenCompra.agregarProducto(itemAAgregar)
		ordenCompra.setFecha(fecha)
	}

	def agregarOrden() {
		getRepoOrdenCompra.create(ordenCompra)
	}

	def eliminar() {
		ordenCompra.listaDeProductos.remove(item)
		costoTotal
	}

	def costoTotal() {
		ordenCompra.getCosto
	}

/**
 * Se deja comentado como otra alternativa
 */

//	def void setProductoSeleccionado(Producto producto){
//		val productoCompuesto =repoProductos.searchById(producto)
//		if (productoCompuesto===null){
//			productoSeleccionado=producto
//		}else{
//			productoSeleccionado=productoCompuesto
//		}
//		
//		
//	}
	def void setProductoSeleccionado(Producto producto) {
		val productoCompuesto = repoProductos.searchProducto(producto)
		if (productoCompuesto === null) {
			productoSeleccionado = producto
		} else {
			productoSeleccionado = productoCompuesto
		}

	}
	
/**
 * Se deja comentado como otra alternativa
 */
//	def void setProductoSeleccionado(Producto producto) {
//		val productoCompuesto = repoProductos.searchProducto(producto)
//		productoSeleccionado = productoCompuesto
//	}
}
