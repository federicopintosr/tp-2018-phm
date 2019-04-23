package persistencias

import java.time.LocalDateTime
import javax.persistence.DiscriminatorValue
import javax.persistence.Entity
import repositorio.memoria.RepoOrdenCompraMemoria
import repositorio.memoria.RepoProductoMemoria
import repositorio.memoria.RepoProveedorMemoria

@Entity
@DiscriminatorValue("2")
class PersistenciaMemoria extends ModoPersistencia {

	new() {
		modoPersistenciaDesc = "Memoria"
		esActivo = true
		fechaActivacion = LocalDateTime.now()

	}

	override getRepositorioOrdenCompra() {
		RepoOrdenCompraMemoria.instance
	}

	override getRepositorioProductos() {
		RepoProductoMemoria.instance
	}

	override getRepositorioProveedores() {
		RepoProveedorMemoria.instance
	}
}
