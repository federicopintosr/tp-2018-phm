package persistencias

import java.time.LocalDateTime
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorType
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import repositorio.interfaces.RepoOrdenCompra
import repositorio.interfaces.RepoProducto
import repositorio.interfaces.RepoProveedor
import repositorio.persistencias.RepoManagerOrdenesDeCompra
import repositorio.persistencias.RepoManagerProductos
import repositorio.persistencias.RepoManagerProveedores

@Accessors
@Entity
@Observable
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name="tipoPersistencia", discriminatorType=DiscriminatorType.INTEGER)
abstract class ModoPersistencia {

	@Id
	@GeneratedValue
	private Long idModoPersistencia

	String modoPersistenciaDesc
	LocalDateTime fechaActivacion
	boolean esActivo

	def RepoOrdenCompra getRepositorioOrdenCompra()

	def RepoProducto getRepositorioProductos()

	def RepoProveedor getRepositorioProveedores()

	def void activar() {
		RepoManagerOrdenesDeCompra.instance.agregarModoPersistencia(this.getRepositorioOrdenCompra())
		RepoManagerProductos.instance.agregarModoPersistencia(this.getRepositorioProductos())
		RepoManagerProveedores.instance.agregarModoPersistencia(this.getRepositorioProveedores())
		esActivo = true
		fechaActivacion = LocalDateTime.now()
	}
}






