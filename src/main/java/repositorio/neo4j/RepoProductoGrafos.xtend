package repositorio.neo4j

import domain.Producto
import domain.ProductoCompuesto
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoProducto

@Accessors
@Observable
class RepoProductoGrafos extends RepoDefaultGrafos<Producto> implements RepoProducto{

	static RepoProductoGrafos instance

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProductoGrafos()
		}
		return instance
	}
	
	override update(Producto _producto){
		session.save(_producto)
	}
	
	override create(Producto _producto) {
		session.save(_producto)
	}
	
	override allInstances() {
		return new ArrayList(session.loadAll(typeof(Producto), PROFUNDIDAD_BUSQUEDA_FULL))
	}
	
	override search(String descripcionBuscada, Integer stockMinimoABuscar, Integer stockMaximoABuscar, boolean soloDebajoStockMinimo) {
		var filtroTrue = new Filter("descripcion", ComparisonOperator.MATCHES, ".*")
		var Filters filtroTotal = filtroTrue.and(filtroTrue)
		if (descripcionBuscada !== null) {
			var Filter  filtroPorDescripcion = new Filter("descripcion", ComparisonOperator.MATCHES, ".*(?i)" + descripcionBuscada + ".*")
			filtroTotal.and(filtroPorDescripcion)
		}
		if (stockMinimoABuscar !== null){
			var Filter filtroPorStockMinimo = new Filter("stockAct", ComparisonOperator.GREATER_THAN, stockMinimoABuscar)
			filtroTotal.and(filtroPorStockMinimo)
		}
		if (stockMaximoABuscar !== null){
			var Filter filtroPorStockMaximo = new Filter("stockAct", ComparisonOperator.LESS_THAN, stockMaximoABuscar)
			filtroTotal.and(filtroPorStockMaximo)
		}
		/**
		 * Estrategia Mixta por limitaciones del Framework con OGM
		 * Filtro en Memoria
		 */
		var resultadoFinal = session.loadAll(typeof(Producto), filtroTotal, PROFUNDIDAD_BUSQUEDA_FULL).toList
		
		if (soloDebajoStockMinimo){
			resultadoFinal = resultadoFinal.filter[prod |  prod.getDebajoStockMinimo ].toList
		}
		return resultadoFinal
	}
	
	override searchById(Producto producto) {
			session.load(typeof(Producto), producto.idProductoNeo4J, PROFUNDIDAD_BUSQUEDA_FULL) as ProductoCompuesto
	}
	
	override searchProducto(Producto producto) {
	
	}
	
}
