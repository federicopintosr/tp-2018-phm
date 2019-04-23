package domain

import java.util.List
import javax.persistence.Column
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.uqbar.commons.model.annotations.Dependencies
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.bson.types.ObjectId


@NodeEntity(label="Producto")
@Observable
@Entity
@Accessors
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoProducto", discriminatorType=DiscriminatorType.INTEGER)
@DiscriminatorValue("1")
@org.mongodb.morphia.annotations.Entity


class Producto extends org.uqbar.commons.model.Entity {

	@Id
	@GeneratedValue
	private Long idProducto
	
	@org.neo4j.ogm.annotation.Id
	@org.neo4j.ogm.annotation.GeneratedValue
	private Long idProductoNeo4J
	
	@org.mongodb.morphia.annotations.Id
	ObjectId idProductoMongo
	
	new(){}

	@Property(name="descripcion")
	@Column(length=150)
	var String descripcion
	
	@Property(name="stockMin")
	@Column
	var Integer stockMin = 0
	
	@Property(name="stockMax")
	@Column
	var Integer stockMax = 0
	
	@Property(name="stockAct")
	@Column
	var Integer stockAct = 0
	
	@Property(name="costo")
	@Column
	var double costo = 0

	def List<Producto>getlistaDeProductos() {}

	def venta(int _cantidad) {
		stockAct = stockAct - _cantidad
	}

	def validarVenta(int cantidad) {
		if (cantidad > stockAct) {
			throw new UserException("Esta tratando de vender más del Stock Actual")
		}
		if (cantidad <= 0) {
			throw new UserException("Debe introducir una cantidad de venta mayor a 0")
		}
	}

	def vender(int cantidad) {
		validarVenta(cantidad)
		venta(cantidad)
	}

	@Dependencies("stockAct","stockMin")
	def Boolean getDebajoStockMinimo() {
		stockAct < stockMin

	}

}
