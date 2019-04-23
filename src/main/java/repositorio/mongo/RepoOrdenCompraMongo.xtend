package repositorio.mongo

import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import java.time.LocalDate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import repositorio.interfaces.RepoOrdenCompra

@Accessors
@TransactionalAndObservable
class RepoOrdenCompraMongo extends RepoDefaultMongo<OrdenCompra> implements RepoOrdenCompra {

	static RepoOrdenCompraMongo instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoOrdenCompraMongo()
		}
		return instance
	}

	override defineUpdateOperations(OrdenCompra oc) {
		
		val operations = ds.createUpdateOperations(entityType)
		operations.set("fecha", oc.fecha)
		operations.set("listaDeProductos", oc.listaDeProductos)
		operations.set("proveedor", oc.proveedor)
	}

	override getEntityType() {
		typeof(OrdenCompra)
	}

	override search(Producto productoBuscado, Proveedor proveedorBuscado, Double costoMinABuscar,
		Double costoMaxABuscar, LocalDate fechaMinABuscar, LocalDate fechaMaxABuscar) {
		val query = ds.createQuery(entityType)
		
		if (proveedorBuscado !== null) {
			query.field("proveedor._id").equal(proveedorBuscado.idProveedorMongo)
		}
		if (productoBuscado !== null) {
			query.field("listaDeProductos.producto._id").equal(productoBuscado.idProductoMongo)
		}
		if (costoMaxABuscar !== null) {
			query.field("costoFinal").lessThan(costoMaxABuscar)
		}
		if (costoMinABuscar !== null) {
			query.field("costoFinal").greaterThan(costoMinABuscar)
		}
		if (fechaMaxABuscar !== null) {
			query.field("fecha").lessThan(fechaMaxABuscar)
		}
		if (fechaMinABuscar !== null) {
			query.field("fecha").greaterThan(fechaMinABuscar)
		}
		query.asList
	}

}
