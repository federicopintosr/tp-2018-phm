package repositorio.neo4j

import domain.OrdenCompra
import domain.Producto
import domain.Proveedor
import java.time.LocalDate
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoOrdenCompra

@Accessors
@Observable
class RepoOrdenCompraGrafos extends RepoDefaultGrafos<OrdenCompra> implements RepoOrdenCompra {
	
	static RepoOrdenCompraGrafos instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoOrdenCompraGrafos()
		}
		return instance
	}

	override allInstances() {
		return new ArrayList(session.loadAll(typeof(OrdenCompra)))
	}
	
	override create(OrdenCompra oc){
		session.save(oc)
	}
	
	override search(Producto productoBuscado, Proveedor proveedorBuscado, Double costoMinABuscar, Double costoMaxABuscar, 
		LocalDate fechaMinABuscar, LocalDate fechaMaxABuscar
	) {
		/**
		 * Estrategia Mixta por limitaciones del Framework con OGM
		 * Filtros en OGM
		 */
		var filtroTrue = new Filter("costoFinal", ComparisonOperator.GREATER_THAN, -1)
		var Filters filtroTotal = filtroTrue.and(filtroTrue)
/**Se deja comentado un intento de filtro avanzado (filtrar por propiedades de otros nodos */
//		if (proveedorBuscado !== null) {
//			var Filter filtroPorProveedor = new Filter("idProveedorNeo4J", ComparisonOperator.EQUALS, proveedorBuscado.idProveedorNeo4J)
//			filtroPorProveedor.nestedPropertyName = "proveedor"
//			filtroPorProveedor.nestedEntityTypeLabel = "Proveedor"
//			filtroPorProveedor.nestedPropertyType = Proveedor
//			filtroPorProveedor.relationshipDirection = Relationship.OUTGOING
//			filtroTotal.and(filtroPorProveedor)
//		}


		
		if (costoMaxABuscar !== null){
			var Filter filtroPorTotalMaximo = new Filter("costoFinal", ComparisonOperator.LESS_THAN, costoMaxABuscar)
			filtroTotal.and(filtroPorTotalMaximo)
		}
		if (costoMinABuscar !== null){
			var Filter filtroPorTotalMinimo = new Filter("costoFinal", ComparisonOperator.GREATER_THAN, costoMinABuscar)
			filtroTotal.and(filtroPorTotalMinimo)
		}
		if (fechaMaxABuscar !== null){
			var Filter filtroPorFechaHasta = new Filter("fecha", ComparisonOperator.LESS_THAN, fechaMaxABuscar)
			filtroTotal.and(filtroPorFechaHasta)
		}
		if (fechaMinABuscar !== null){
			var Filter filtroPorFechaDesde = new Filter("fecha", ComparisonOperator.GREATER_THAN, fechaMinABuscar)
			filtroTotal.and(filtroPorFechaDesde)
		}
		var listafiltradaOgm =session.loadAll(typeof(OrdenCompra), filtroTotal, PROFUNDIDAD_BUSQUEDA_FULL).toList
		
		/**
		 * Estrategia Mixta por limitaciones del Framework con OGM
		 * Filtros en Memoria
		 */
		if(proveedorBuscado !== null){
		listafiltradaOgm = listafiltradaOgm.filter[ordenCompra |  ordenCompra.proveedor.descripcion == proveedorBuscado.descripcion ].toList
			
		}
		
		if(productoBuscado !== null){
			listafiltradaOgm = listafiltradaOgm.filter[ordenCompra | ordenCompra.getListaNombreProductos.contains(productoBuscado.descripcion)].toList
		}
		
		listafiltradaOgm
	}	
	
	override update(OrdenCompra oc) {
		session.save(oc)
	}
	
}