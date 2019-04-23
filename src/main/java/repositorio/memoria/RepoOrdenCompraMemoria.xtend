package repositorio.memoria

import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import java.time.LocalDate
import org.apache.commons.collections15.Predicate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.CollectionBasedRepo
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repositorio.interfaces.RepoOrdenCompra

@Accessors
@TransactionalAndObservable
class RepoOrdenCompraMemoria  extends CollectionBasedRepo<OrdenCompra> implements RepoOrdenCompra {
	
	static RepoOrdenCompraMemoria instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoOrdenCompraMemoria()
		}
		return instance
	}

	override getEntityType() {
		typeof(OrdenCompra)
	}
	
	override def Predicate<OrdenCompra> getCriterio(OrdenCompra example) {
		null
	}

	override createExample() {
		new OrdenCompra
	}
	
	override search(Producto productoBuscado, Proveedor proveedorBuscado, Double costoMinABuscar, Double costoMaxABuscar, LocalDate fechaMinABuscar, LocalDate fechaMaxABuscar ) {
		allInstances.filter [ orden |
			matchProveedor(proveedorBuscado, orden) &&
			matchProducto(productoBuscado, orden) &&
			busquedaFechaMin(fechaMinABuscar, orden) &&
			busquedaFechaMax(fechaMaxABuscar, orden)&&
			busquedaCostokMin(costoMinABuscar, orden) &&
			busquedaCostokMax(costoMaxABuscar, orden) 
		].toList
	}

	def matchProveedor(Proveedor expectedValue, OrdenCompra realValue) {
		if (expectedValue === null) {
			return true
		}
		realValue.proveedor == expectedValue
	}
	
	def matchProducto(Producto expectedValue, OrdenCompra realValue) {
		if (expectedValue === null) {
			return true
		}
		realValue.getListaProductos.contains(expectedValue)
		
	}

	def busquedaCostokMin(Double costoBuscado, OrdenCompra ordenReal) {
		if (costoBuscado === null) {
			return true
		}
		costoBuscado < ordenReal.costo

	}

	def busquedaCostokMax(Double costoBuscado, OrdenCompra ordenReal) {
		if (costoBuscado === null) {
			return true
		}
		costoBuscado > ordenReal.costo

	}

	def busquedaFechaMin(LocalDate fechaBuscada, OrdenCompra ordenReal) {
		if (fechaBuscada === null) {
			return true
		}
		fechaBuscada < ordenReal.fecha

	}

	def busquedaFechaMax(LocalDate fechaBuscada, OrdenCompra ordenReal) {
		if (fechaBuscada === null) {
			return true
		}
		fechaBuscada > ordenReal.fecha

	}
		
}
