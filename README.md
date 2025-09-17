# 📌 Sprint 1 (Milestone: *Sprint 1*)

## HU-1: Subir planos en DWG/PDF y visualizarlos en vista previa
- **Descripción:** Como usuario quiero subir planos en formato DWG y PDF para almacenarlos correctamente y verlos en una vista previa.  
- **Criterios de aceptación:**  
  - Se permite subir archivos DWG y PDF.  
  - La vista previa debe mostrarse sin necesidad de software externo.  
- **Puntos:** 6  
- **Labels:** `frontend`, `HU`, `Sprint-1`

---

## HUT-1: Carga rápida (menos de 3 segundos) en vista previa
- **Descripción:** Como usuario técnico quiero que la vista previa cargue en menos de 3 segundos para optimizar la experiencia.  
- **Criterios de aceptación:**  
  - El render de un plano DWG/PDF no supera 3 segundos en condiciones normales.  
- **Puntos:** 3  
- **Labels:** `backend`, `HUT`, `Sprint-1`

---

## HU-3: Visualizar planos sin necesidad de descargarlos
- **Descripción:** Como usuario quiero visualizar un plano sin descargarlo para trabajar de forma más ágil y segura.  
- **Criterios de aceptación:**  
  - La aplicación muestra visor integrado.  
  - Se evita la descarga directa si no hay permisos.  
- **Puntos:** 3  
- **Labels:** `frontend`, `HU`, `Sprint-1`

---

## HUT-5: Seguridad: autenticación segura y bloqueo tras 3 intentos fallidos
- **Descripción:** Como usuario técnico quiero que el sistema bloquee el acceso tras 3 intentos fallidos para reforzar la seguridad.  
- **Criterios de aceptación:**  
  - Se restringe el login tras 3 intentos.  
  - El desbloqueo requiere restablecimiento de contraseña.  
- **Puntos:** 4  
- **Labels:** `backend`, `HUT`, `Sprint-1`

---

# 📌 Sprint 2 (Milestone: *Sprint 2*)

## HU-2: Clasificar y filtrar planos por zona, tipo y versión
- **Descripción:** Como usuario quiero clasificar y filtrar planos por zona, tipo y versión para encontrarlos fácilmente.  
- **Criterios de aceptación:**  
  - Filtros por zona, subzona, sistema y versión.  
  - Se debe mostrar lista ordenada y clara.  
- **Puntos:** 8  
- **Labels:** `frontend`, `backend`, `HU`, `Sprint-2`

---

## HU-5: Asignar roles y cambio de contraseña cada 2 meses
- **Descripción:** Como administrador quiero asignar roles y obligar al cambio de contraseña cada 2 meses para mejorar la seguridad.  
- **Criterios de aceptación:**  
  - Gestión de roles (admin, editor, lector).  
  - Cambio de contraseña obligatorio cada 60 días.  
- **Puntos:** 6  
- **Labels:** `backend`, `HU`, `Sprint-2`

---

## HUT-4: Respaldo automático cada 12 horas y protección contra edición/descarga
- **Descripción:** Como usuario técnico quiero que los archivos tengan respaldo automático y protección contra edición/descarga no autorizada.  
- **Criterios de aceptación:**  
  - Backups automáticos cada 12h.  
  - Permisos que bloqueen edición/descarga sin rol.  
- **Puntos:** 5  
- **Labels:** `database`, `HUT`, `Sprint-2`

---

# 📌 Sprint 3 (Milestone: *Sprint 3*)

## HU-4: Registrar versiones de planos, historial técnico y notificaciones
- **Descripción:** Como usuario quiero registrar versiones de planos con historial técnico y recibir notificaciones de cambios.  
- **Criterios de aceptación:**  
  - Control de versiones completo.  
  - Historial de cambios por fecha, autor y comentario.  
  - Notificación automática al actualizar plano crítico.  
- **Puntos:** 6  
- **Labels:** `backend`, `HU`, `Sprint-3`

---

## HU-6: Acceso a planos antiguos para usuarios externos en modo lectura
- **Descripción:** Como visitante externo quiero acceder a planos antiguos en modo lectura segura para consultarlos sin riesgos.  
- **Criterios de aceptación:**  
  - Restricción de edición y descarga.  
  - Solo lectura de planos antiguos.  
- **Puntos:** 3  
- **Labels:** `frontend`, `HU`, `Sprint-3`

---

## HUT-2: Sistema disponible al menos el 98% del tiempo
- **Descripción:** Como usuario técnico quiero que el sistema esté disponible el 98% del tiempo mensual para asegurar continuidad de trabajo.  
- **Criterios de aceptación:**  
  - Métricas de uptime >= 98%.  
  - Monitoreo básico implementado.  
- **Puntos:** 4  
- **Labels:** `backend`, `HUT`, `Sprint-3`

---

## HUT-3: Interfaz accesible desde móviles y soporte para 150 usuarios concurrentes
- **Descripción:** Como usuario técnico quiero que el sistema soporte 150 usuarios concurrentes y sea accesible en móviles.  
- **Criterios de aceptación:**  
  - Tests de concurrencia hasta 150 usuarios.  
  - Compatibilidad con navegadores móviles.  
- **Puntos:** 5  
- **Labels:** `frontend`, `HUT`, `Sprint-3`
