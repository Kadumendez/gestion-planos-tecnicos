
DROP DATABASE IF EXISTS planos_app;
CREATE DATABASE planos_app
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE planos_app;

SET sql_safe_updates = 0;
SET time_zone = '+00:00';
SET FOREIGN_KEY_CHECKS = 0;





-- Estados básicos
CREATE TABLE estado_usuario (
  id_estado TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(40) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE estado_plano (
  id_estado TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(40) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE estado_version (
  id_estado TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(40) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE estado_notificacion (
  id_estado TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(40) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Colaborador y usuarios
CREATE TABLE colaborador (
  id_colaborador   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombres          VARCHAR(120) NOT NULL,
  apellidos        VARCHAR(120) NOT NULL,
  dni              VARCHAR(15)  NULL,
  direccion        VARCHAR(200) NULL,
  telefono         VARCHAR(20)  NULL,
  fecha_nacimiento DATE         NULL,
  fecha_ingreso    DATE         NULL,
  cargo            VARCHAR(100) NULL,
  created_at       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at       DATETIME NULL,
  UNIQUE KEY ux_colaborador_dni (dni)
) ENGINE=InnoDB;

CREATE TABLE usuario (
  id_usuario     INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  id_colaborador INT UNSIGNED NULL,
  nombre_mostrar VARCHAR(150) NOT NULL,
  correo         VARCHAR(180) NOT NULL,
  id_estado      TINYINT UNSIGNED NOT NULL,
  created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at     DATETIME NULL,
  created_user   INT UNSIGNED NULL,
  updated_user   INT UNSIGNED NULL,
  deleted_user   INT UNSIGNED NULL,
  CONSTRAINT fk_usuario_colaborador FOREIGN KEY (id_colaborador) REFERENCES colaborador(id_colaborador)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_usuario_estado FOREIGN KEY (id_estado) REFERENCES estado_usuario(id_estado)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY ux_usuario_correo (correo),
  KEY ix_usuario_estado (id_estado)
) ENGINE=InnoDB;

CREATE TABLE autenticacion (
  id_usuario    INT UNSIGNED PRIMARY KEY,
  password_hash VARCHAR(255) NOT NULL,
  last_login_at DATETIME NULL,
  must_reset    TINYINT(1) NOT NULL DEFAULT 0,
  created_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_auth_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Roles y permisos
CREATE TABLE rol (
  id_rol      INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre      VARCHAR(120) NOT NULL UNIQUE,
  descripcion VARCHAR(255) NULL,
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE permiso (
  id_permiso  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre      VARCHAR(120) NOT NULL UNIQUE,
  descripcion VARCHAR(255) NULL,
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE rol_permiso (
  id_rol     INT UNSIGNED NOT NULL,
  id_permiso INT UNSIGNED NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_rol, id_permiso),
  CONSTRAINT fk_rolperm_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_rolperm_permiso FOREIGN KEY (id_permiso) REFERENCES permiso(id_permiso)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE usuario_rol (
  id_usuario  INT UNSIGNED NOT NULL,
  id_rol      INT UNSIGNED NOT NULL,
  asignado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_usuario, id_rol),
  CONSTRAINT fk_usuariorol_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_usuariorol_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Zonas, subzonas y máquinas
CREATE TABLE zona (
  id_zona   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre    VARCHAR(200) NOT NULL,
  codigo    VARCHAR(120) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY ux_zona_codigo (codigo)
) ENGINE=InnoDB;

CREATE TABLE subzona (
  id_subzona INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  id_zona    INT UNSIGNED NOT NULL,
  nombre     VARCHAR(200) NOT NULL,
  codigo     VARCHAR(120) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_subzona_zona FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
    ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE KEY ux_subzona_codigo (codigo),
  KEY ix_subzona_zona (id_zona)
) ENGINE=InnoDB;

CREATE TABLE maquina (
  id_maquina INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  codigo     VARCHAR(120) NOT NULL,
  nombre     VARCHAR(200) NULL,
  tipo       VARCHAR(100) NULL,
  id_zona    INT UNSIGNED NULL,
  id_subzona INT UNSIGNED NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY ux_maquina_codigo (codigo),
  KEY ix_maquina_zonas (id_zona, id_subzona),
  CONSTRAINT fk_maquina_zona FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_maquina_subzona FOREIGN KEY (id_subzona) REFERENCES subzona(id_subzona)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Planos
CREATE TABLE plano (
  id_plano     INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  nombre       VARCHAR(200) NOT NULL,
  codigo       VARCHAR(120) NOT NULL,
  descripcion  TEXT NULL,
  id_maquina   INT UNSIGNED NULL,
  id_zona      INT UNSIGNED NULL,
  id_subzona   INT UNSIGNED NULL,
  id_estado    TINYINT UNSIGNED NOT NULL,
  created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at   DATETIME NULL,
  created_user INT UNSIGNED NULL,
  updated_user INT UNSIGNED NULL,
  deleted_user INT UNSIGNED NULL,
  CONSTRAINT fk_plano_maquina FOREIGN KEY (id_maquina) REFERENCES maquina(id_maquina)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_plano_zona FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_plano_subzona FOREIGN KEY (id_subzona) REFERENCES subzona(id_subzona)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_plano_estado FOREIGN KEY (id_estado) REFERENCES estado_plano(id_estado)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY ux_plano_codigo (codigo),
  KEY ix_plano_estado (id_estado),
  KEY ix_plano_loc (id_zona, id_subzona),
  KEY ix_plano_created_at (created_at)
) ENGINE=InnoDB;

CREATE TABLE planoversion (
  id_version  INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  id_plano    INT UNSIGNED NOT NULL,
  nro_version INT UNSIGNED NOT NULL,
  id_usuario  INT UNSIGNED NOT NULL,
  id_estado   TINYINT UNSIGNED NOT NULL,
  comentarios TEXT NULL,
  hash_integridad VARCHAR(255) NULL,
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at  DATETIME NULL,
  created_user INT UNSIGNED NULL,
  updated_user INT UNSIGNED NULL,
  deleted_user INT UNSIGNED NULL,
  CONSTRAINT fk_pv_plano FOREIGN KEY (id_plano) REFERENCES plano(id_plano)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_pv_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_pv_estado FOREIGN KEY (id_estado) REFERENCES estado_version(id_estado)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY ux_pv_plano_nro (id_plano, nro_version),
  UNIQUE KEY ux_pv_hash (hash_integridad),
  KEY ix_pv_plano (id_plano),
  KEY ix_pv_estado (id_estado),
  KEY ix_pv_created (created_at)
) ENGINE=InnoDB;

CREATE TABLE planoarchivo (
  id_archivo   INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  id_version   INT UNSIGNED NOT NULL,
  storage_key  VARCHAR(255) NOT NULL,
  formato      VARCHAR(40) NOT NULL,
  tamano_bytes BIGINT UNSIGNED NOT NULL,
  checksum     VARCHAR(255) NULL,
  created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_pa_version FOREIGN KEY (id_version) REFERENCES planoversion(id_version)
    ON DELETE CASCADE ON UPDATE CASCADE,
  UNIQUE KEY ux_pa_checksum (checksum),
  KEY ix_pa_version (id_version),
  KEY ix_pa_formato (formato)
) ENGINE=InnoDB;

-- Notificaciones
CREATE TABLE notificacion (
  id_notificacion INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  fecha           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  id_estado       TINYINT UNSIGNED NOT NULL,
  payload         JSON NULL,
  CONSTRAINT fk_notif_estado FOREIGN KEY (id_estado) REFERENCES estado_notificacion(id_estado)
    ON DELETE RESTRICT ON UPDATE CASCADE,
  KEY ix_notif_estado (id_estado),
  KEY ix_notif_fecha (fecha)
) ENGINE=InnoDB;

CREATE TABLE usuario_notificacion (
  id_usuario      INT UNSIGNED NOT NULL,
  id_notificacion INT UNSIGNED NOT NULL,
  recibido_en     DATETIME NULL,
  leido_en        DATETIME NULL,
  PRIMARY KEY (id_usuario, id_notificacion),
  CONSTRAINT fk_un_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_un_notificacion FOREIGN KEY (id_notificacion) REFERENCES notificacion(id_notificacion)
    ON DELETE CASCADE ON UPDATE CASCADE,
  KEY ix_un_leido (leido_en),
  KEY ix_un_estado (id_usuario, leido_en)
) ENGINE=InnoDB;

-- Logs y auditoría
CREATE TABLE logsistema (
  id_log    BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  id_usuario INT UNSIGNED NULL,
  accion    VARCHAR(120) NOT NULL,
  contexto  JSON NULL,
  fecha     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_log_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
    ON DELETE SET NULL ON UPDATE CASCADE,
  KEY ix_log_fecha (fecha),
  KEY ix_log_usuario (id_usuario),
  KEY ix_log_accion (accion)
) ENGINE=InnoDB;

CREATE TABLE auditoria_evento (
  id_evento   BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  tabla       VARCHAR(128) NOT NULL,
  pk_valor    VARCHAR(128) NOT NULL,
  accion      ENUM('INSERT','UPDATE','DELETE') NOT NULL,
  cambiado_por INT UNSIGNED NULL,
  cambiado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  antes_json  JSON NULL,
  despues_json JSON NULL,
  comentario  VARCHAR(255) NULL,
  KEY ix_aud_tabla_pk (tabla, pk_valor),
  KEY ix_aud_fecha (cambiado_en),
  KEY ix_aud_usuario (cambiado_por),
  KEY ix_aud_tabla_fecha (tabla, cambiado_en)
) ENGINE=InnoDB;

-- Triggers (igual que en tu script, ya usando JSON)
DELIMITER $$
/* ... (aquí van los triggers como los tienes, no los repito por espacio) ... */
DELIMITER ;

-- Inserts iniciales
INSERT INTO estado_usuario (nombre) VALUES ('activo'), ('inactivo'), ('bloqueado');
INSERT INTO estado_plano (nombre)   VALUES ('borrador'), ('en_revision'), ('aprobado'), ('archivado');
INSERT INTO estado_version (nombre) VALUES ('vigente'), ('obsoleta'), ('rechazada');
INSERT INTO estado_notificacion (nombre) VALUES ('enviada'), ('entregada'), ('leida');
INSERT INTO medio_notificacion (nombre)  VALUES ('web'), ('email'), ('push'), ('sms');

-- Roles y permisos
INSERT INTO rol (nombre, descripcion) VALUES
  ('Admin', 'Administrador del sistema'),
  ('Editor', 'Carga y edición de planos'),
  ('Lector', 'Solo lectura');

INSERT INTO permiso (nombre, descripcion) VALUES
  ('PLANO_VER', 'Ver planos'),
  ('PLANO_EDITAR', 'Crear/editar planos'),
  ('PLANO_APROBAR', 'Aprobar/flujos'),
  ('USUARIO_ADMIN', 'Administración de usuarios');

INSERT INTO rol_permiso (id_rol, id_permiso)
SELECT r.id_rol, p.id_permiso FROM rol r JOIN permiso p WHERE r.nombre='Admin'
UNION ALL
SELECT r.id_rol, p.id_permiso FROM rol r JOIN permiso p
WHERE r.nombre='Editor' AND p.nombre IN ('PLANO_VER','PLANO_EDITAR')
UNION ALL
SELECT r.id_rol, p.id_permiso FROM rol r JOIN permiso p
WHERE r.nombre='Lector' AND p.nombre='PLANO_VER';

-- Usuario demo
INSERT INTO colaborador (nombres, apellidos, dni) VALUES ('Kadú', 'Desposorio', '99999999');
INSERT INTO usuario (id_colaborador, nombre_mostrar, correo, id_estado)
VALUES (LAST_INSERT_ID(), 'Kadú Desposorio', 'kadu@example.com', 1);

INSERT INTO autenticacion (id_usuario, password_hash)
VALUES (LAST_INSERT_ID(), '$2y$10$hash_de_ejemplo_reemplazar_por_bcrypt');

INSERT INTO usuario_rol (id_usuario, id_rol)
SELECT u.id_usuario, r.id_rol
FROM usuario u JOIN rol r
WHERE u.correo='kadu@example.com' AND r.nombre='Admin';

SET FOREIGN_KEY_CHECKS = 1;
