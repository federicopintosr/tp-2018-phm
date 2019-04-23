package domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Relationship
import org.uqbar.commons.model.annotations.Observable
import org.bson.types.ObjectId

@NodeEntity(label="ItemProducto")
@org.mongodb.morphia.annotations.Entity



@Entity
@Observable
@Accessors

class ItemProducto {
	@Id
	@GeneratedValue
	private Long idItemProducto
	
	@org.neo4j.ogm.annotation.Id
	@org.neo4j.ogm.annotation.GeneratedValue
	private Long idItemProductoNeo4J
	
	@org.mongodb.morphia.annotations.Id
	ObjectId idItemProductoMongo
	
	@Column
	int cantidad
	
	@Relationship(type = "TOTAL_DE_P", direction = "OUTGOING")
	@OneToOne
	Producto producto

	
	def costo (){
		producto.costo * cantidad
		
	}
	
	def descripcion(){
		cantidad + " " + producto.descripcion
	}
}