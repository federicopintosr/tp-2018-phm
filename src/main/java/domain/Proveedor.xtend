package domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.uqbar.commons.model.annotations.Observable

@NodeEntity(label="Proveedor")

@Accessors
@Observable
@Entity

@org.mongodb.morphia.annotations.Entity
class Proveedor extends org.uqbar.commons.model.Entity {
	@Id
	@GeneratedValue
	private Long idProovedor

	
	@org.neo4j.ogm.annotation.Id
	@org.neo4j.ogm.annotation.GeneratedValue
	@Property(name= "idProveedorNeo4J")
	private Long idProveedorNeo4J
	
	@org.mongodb.morphia.annotations.Id
	ObjectId idProveedorMongo
	

	@Property(name="descripcion")
	@Column(length=150)
	var String descripcion

	new() {
	}

}
