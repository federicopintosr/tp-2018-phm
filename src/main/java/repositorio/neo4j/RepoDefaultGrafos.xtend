package repositorio.neo4j

import org.neo4j.ogm.config.Configuration
import org.neo4j.ogm.session.SessionFactory
import repositorio.interfaces.Repositorio

abstract class RepoDefaultGrafos<T> implements Repositorio<T> {

	public static int PROFUNDIDAD_BUSQUEDA_FULL = -1
	public static int PROFUNDIDAD_BUSQUEDA_LISTA = 0
	public static int PROFUNDIDAD_BUSQUEDA_CONCRETA = 1

	static Configuration configuration = new Configuration.Builder()
		.uri("bolt://localhost")
		.credentials("neo4j", "root")
		.build()

	public static SessionFactory sessionFactory = new SessionFactory(configuration, "domain")

	protected def getSession() {
		sessionFactory.openSession
	}
}
