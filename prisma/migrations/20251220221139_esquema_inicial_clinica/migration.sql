-- CreateTable
CREATE TABLE `Usuario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `passwordHash` VARCHAR(191) NOT NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'activo',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizadoEn` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Usuario_username_key`(`username`),
    UNIQUE INDEX `Usuario_email_key`(`email`),
    INDEX `Usuario_username_idx`(`username`),
    INDEX `Usuario_email_idx`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Rol` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(100) NOT NULL,
    `descripcion` TEXT NOT NULL,

    UNIQUE INDEX `Rol_nombre_key`(`nombre`),
    INDEX `Rol_nombre_idx`(`nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UsuarioRol` (
    `usuarioId` INTEGER NOT NULL,
    `rolId` INTEGER NOT NULL,

    INDEX `UsuarioRol_rolId_idx`(`rolId`),
    PRIMARY KEY (`usuarioId`, `rolId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Permiso` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `clave` VARCHAR(100) NOT NULL,
    `descripcion` TEXT NOT NULL,

    UNIQUE INDEX `Permiso_clave_key`(`clave`),
    INDEX `Permiso_clave_idx`(`clave`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RolPermiso` (
    `rolId` INTEGER NOT NULL,
    `permisoId` INTEGER NOT NULL,

    INDEX `RolPermiso_permisoId_idx`(`permisoId`),
    PRIMARY KEY (`rolId`, `permisoId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PersonaAtendida` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tipoDocumento` VARCHAR(20) NOT NULL,
    `numeroDocumento` VARCHAR(50) NOT NULL,
    `nombres` VARCHAR(100) NOT NULL,
    `apellidos` VARCHAR(100) NOT NULL,
    `fechaNacimiento` DATETIME(3) NOT NULL,
    `sexo` VARCHAR(20) NOT NULL,
    `correo` VARCHAR(255) NULL,
    `telefono` VARCHAR(20) NULL,
    `direccion` TEXT NULL,
    `contactoEmergencia` VARCHAR(200) NULL,
    `alergias` TEXT NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'activo',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizadoEn` DATETIME(3) NOT NULL,

    UNIQUE INDEX `PersonaAtendida_numeroDocumento_key`(`numeroDocumento`),
    INDEX `PersonaAtendida_numeroDocumento_idx`(`numeroDocumento`),
    INDEX `PersonaAtendida_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Profesional` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombres` VARCHAR(100) NOT NULL,
    `apellidos` VARCHAR(100) NOT NULL,
    `registroProfesional` VARCHAR(100) NOT NULL,
    `especialidad` VARCHAR(100) NOT NULL,
    `correo` VARCHAR(255) NOT NULL,
    `telefono` VARCHAR(20) NOT NULL,
    `agendaHabilitada` BOOLEAN NOT NULL DEFAULT true,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'activo',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizadoEn` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Profesional_registroProfesional_key`(`registroProfesional`),
    UNIQUE INDEX `Profesional_correo_key`(`correo`),
    INDEX `Profesional_especialidad_idx`(`especialidad`),
    INDEX `Profesional_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UnidadAtencion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(200) NOT NULL,
    `tipo` VARCHAR(50) NOT NULL,
    `direccion` TEXT NOT NULL,
    `telefono` VARCHAR(20) NOT NULL,
    `horarioReferencia` VARCHAR(200) NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'activo',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizadoEn` DATETIME(3) NOT NULL,

    INDEX `UnidadAtencion_tipo_idx`(`tipo`),
    INDEX `UnidadAtencion_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Agenda` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `profesionalId` INTEGER NOT NULL,
    `unidadId` INTEGER NOT NULL,
    `inicio` DATETIME(3) NOT NULL,
    `fin` DATETIME(3) NOT NULL,
    `capacidad` INTEGER NOT NULL DEFAULT 1,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'abierto',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizadoEn` DATETIME(3) NOT NULL,

    INDEX `Agenda_profesionalId_idx`(`profesionalId`),
    INDEX `Agenda_unidadId_idx`(`unidadId`),
    INDEX `Agenda_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cita` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `personaId` INTEGER NOT NULL,
    `profesionalId` INTEGER NOT NULL,
    `unidadId` INTEGER NOT NULL,
    `agendaId` INTEGER NULL,
    `inicio` DATETIME(3) NOT NULL,
    `fin` DATETIME(3) NOT NULL,
    `motivo` VARCHAR(500) NOT NULL,
    `canal` VARCHAR(50) NOT NULL,
    `estado` VARCHAR(50) NOT NULL DEFAULT 'solicitada',
    `observaciones` TEXT NULL,
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizadoEn` DATETIME(3) NOT NULL,

    INDEX `Cita_personaId_idx`(`personaId`),
    INDEX `Cita_profesionalId_idx`(`profesionalId`),
    INDEX `Cita_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EpisodioAtencion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `personaId` INTEGER NOT NULL,
    `profesionalId` INTEGER NOT NULL,
    `fechaApertura` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `motivo` VARCHAR(500) NOT NULL,
    `tipo` VARCHAR(50) NOT NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'abierto',
    `actualizadoEn` DATETIME(3) NOT NULL,

    INDEX `EpisodioAtencion_personaId_idx`(`personaId`),
    INDEX `EpisodioAtencion_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `NotaClinica` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `episodioId` INTEGER NOT NULL,
    `profesionalId` INTEGER NOT NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `subjetivo` TEXT NULL,
    `objetivo` TEXT NULL,
    `analisis` TEXT NULL,
    `plan` TEXT NULL,
    `version` INTEGER NOT NULL DEFAULT 1,
    `actualizadoEn` DATETIME(3) NOT NULL,

    INDEX `NotaClinica_episodioId_idx`(`episodioId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Diagnostico` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `episodioId` INTEGER NOT NULL,
    `codigo` VARCHAR(50) NOT NULL,
    `descripcion` TEXT NOT NULL,
    `tipo` VARCHAR(50) NOT NULL,
    `principal` BOOLEAN NOT NULL DEFAULT false,
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Diagnostico_episodioId_idx`(`episodioId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Consentimiento` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `personaId` INTEGER NOT NULL,
    `episodioId` INTEGER NULL,
    `tipoProcedimiento` VARCHAR(200) NOT NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `metodo` VARCHAR(50) NOT NULL,
    `archivoId` VARCHAR(255) NULL,

    INDEX `Consentimiento_personaId_idx`(`personaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Orden` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `episodioId` INTEGER NOT NULL,
    `tipo` VARCHAR(50) NOT NULL,
    `prioridad` VARCHAR(50) NOT NULL DEFAULT 'normal',
    `estado` VARCHAR(50) NOT NULL DEFAULT 'emitida',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizadoEn` DATETIME(3) NOT NULL,

    INDEX `Orden_episodioId_idx`(`episodioId`),
    INDEX `Orden_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `OrdenItem` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ordenId` INTEGER NOT NULL,
    `codigo` VARCHAR(100) NOT NULL,
    `descripcion` TEXT NOT NULL,
    `indicaciones` TEXT NULL,

    INDEX `OrdenItem_ordenId_idx`(`ordenId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Resultado` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ordenId` INTEGER NOT NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `resumen` TEXT NULL,
    `archivoId` VARCHAR(255) NULL,
    `version` INTEGER NOT NULL DEFAULT 1,
    `actualizadoEn` DATETIME(3) NOT NULL,

    INDEX `Resultado_ordenId_idx`(`ordenId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Prestacion` (
    `codigo` VARCHAR(100) NOT NULL,
    `nombre` VARCHAR(255) NOT NULL,
    `grupo` VARCHAR(100) NOT NULL,
    `requisitos` TEXT NULL,
    `tiempoEstimado` INTEGER NULL,
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Prestacion_grupo_idx`(`grupo`),
    PRIMARY KEY (`codigo`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Aseguradora` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(200) NOT NULL,
    `nit` VARCHAR(50) NOT NULL,
    `contacto` VARCHAR(200) NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'activo',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Aseguradora_nit_key`(`nit`),
    INDEX `Aseguradora_nit_idx`(`nit`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PlanCobertura` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `aseguradoraId` INTEGER NOT NULL,
    `nombre` VARCHAR(200) NOT NULL,
    `condicionesGenerales` TEXT NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'activo',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `PlanCobertura_aseguradoraId_idx`(`aseguradoraId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Afiliacion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `personaId` INTEGER NOT NULL,
    `planId` INTEGER NOT NULL,
    `numeroPoliza` VARCHAR(100) NOT NULL,
    `vigenteDesde` DATETIME(3) NOT NULL,
    `vigenteHasta` DATETIME(3) NOT NULL,
    `copago` DECIMAL(10, 2) NOT NULL,
    `cuotaModeradora` DECIMAL(10, 2) NOT NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'activa',
    `fechaCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `Afiliacion_numeroPoliza_idx`(`numeroPoliza`),
    UNIQUE INDEX `Afiliacion_personaId_planId_key`(`personaId`, `planId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Arancel` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `prestacionCodigo` VARCHAR(191) NOT NULL,
    `planId` INTEGER NULL,
    `valorBase` DECIMAL(15, 2) NOT NULL,
    `impuestos` DECIMAL(10, 2) NOT NULL DEFAULT 0,
    `vigenteDesde` DATETIME(3) NOT NULL,
    `vigenteHasta` DATETIME(3) NOT NULL,
    `estado` VARCHAR(20) NOT NULL DEFAULT 'vigente',

    INDEX `Arancel_planId_idx`(`planId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Factura` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `numero` VARCHAR(50) NOT NULL,
    `fechaEmision` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `personaId` INTEGER NULL,
    `aseguradoraId` INTEGER NULL,
    `moneda` VARCHAR(10) NOT NULL DEFAULT 'COP',
    `subtotal` DECIMAL(15, 2) NOT NULL,
    `impuestos` DECIMAL(15, 2) NOT NULL,
    `total` DECIMAL(15, 2) NOT NULL,
    `estado` VARCHAR(50) NOT NULL DEFAULT 'emitida',
    `actualizadoEn` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Factura_numero_key`(`numero`),
    INDEX `Factura_personaId_idx`(`personaId`),
    INDEX `Factura_aseguradoraId_idx`(`aseguradoraId`),
    INDEX `Factura_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `FacturaItem` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `facturaId` INTEGER NOT NULL,
    `prestacionCodigo` VARCHAR(191) NOT NULL,
    `descripcion` TEXT NOT NULL,
    `cantidad` INTEGER NOT NULL,
    `valorUnitario` DECIMAL(15, 2) NOT NULL,
    `impuestos` DECIMAL(15, 2) NOT NULL,
    `total` DECIMAL(15, 2) NOT NULL,

    INDEX `FacturaItem_facturaId_idx`(`facturaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Pago` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `facturaId` INTEGER NOT NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `monto` DECIMAL(15, 2) NOT NULL,
    `medio` VARCHAR(50) NOT NULL,
    `referencia` VARCHAR(255) NULL,
    `estado` VARCHAR(50) NOT NULL DEFAULT 'exitoso',

    INDEX `Pago_facturaId_idx`(`facturaId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notificacion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `tipo` VARCHAR(50) NOT NULL,
    `plantilla` VARCHAR(255) NULL,
    `destinatario` VARCHAR(255) NOT NULL,
    `payload` TEXT NOT NULL,
    `estado` VARCHAR(50) NOT NULL DEFAULT 'enviado',
    `timestamp` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `reintentos` INTEGER NOT NULL DEFAULT 0,

    INDEX `Notificacion_estado_idx`(`estado`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BitacoraAccesos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `usuarioId` INTEGER NULL,
    `recurso` VARCHAR(255) NOT NULL,
    `accion` VARCHAR(50) NOT NULL,
    `ip` VARCHAR(50) NULL,
    `userAgent` TEXT NULL,
    `fecha` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `BitacoraAccesos_usuarioId_idx`(`usuarioId`),
    INDEX `BitacoraAccesos_fecha_idx`(`fecha`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `UsuarioRol` ADD CONSTRAINT `UsuarioRol_usuarioId_fkey` FOREIGN KEY (`usuarioId`) REFERENCES `Usuario`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UsuarioRol` ADD CONSTRAINT `UsuarioRol_rolId_fkey` FOREIGN KEY (`rolId`) REFERENCES `Rol`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RolPermiso` ADD CONSTRAINT `RolPermiso_rolId_fkey` FOREIGN KEY (`rolId`) REFERENCES `Rol`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RolPermiso` ADD CONSTRAINT `RolPermiso_permisoId_fkey` FOREIGN KEY (`permisoId`) REFERENCES `Permiso`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Agenda` ADD CONSTRAINT `Agenda_profesionalId_fkey` FOREIGN KEY (`profesionalId`) REFERENCES `Profesional`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Agenda` ADD CONSTRAINT `Agenda_unidadId_fkey` FOREIGN KEY (`unidadId`) REFERENCES `UnidadAtencion`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cita` ADD CONSTRAINT `Cita_personaId_fkey` FOREIGN KEY (`personaId`) REFERENCES `PersonaAtendida`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cita` ADD CONSTRAINT `Cita_profesionalId_fkey` FOREIGN KEY (`profesionalId`) REFERENCES `Profesional`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cita` ADD CONSTRAINT `Cita_unidadId_fkey` FOREIGN KEY (`unidadId`) REFERENCES `UnidadAtencion`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cita` ADD CONSTRAINT `Cita_agendaId_fkey` FOREIGN KEY (`agendaId`) REFERENCES `Agenda`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EpisodioAtencion` ADD CONSTRAINT `EpisodioAtencion_personaId_fkey` FOREIGN KEY (`personaId`) REFERENCES `PersonaAtendida`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EpisodioAtencion` ADD CONSTRAINT `EpisodioAtencion_profesionalId_fkey` FOREIGN KEY (`profesionalId`) REFERENCES `Profesional`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NotaClinica` ADD CONSTRAINT `NotaClinica_episodioId_fkey` FOREIGN KEY (`episodioId`) REFERENCES `EpisodioAtencion`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NotaClinica` ADD CONSTRAINT `NotaClinica_profesionalId_fkey` FOREIGN KEY (`profesionalId`) REFERENCES `Profesional`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Diagnostico` ADD CONSTRAINT `Diagnostico_episodioId_fkey` FOREIGN KEY (`episodioId`) REFERENCES `EpisodioAtencion`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Consentimiento` ADD CONSTRAINT `Consentimiento_personaId_fkey` FOREIGN KEY (`personaId`) REFERENCES `PersonaAtendida`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Consentimiento` ADD CONSTRAINT `Consentimiento_episodioId_fkey` FOREIGN KEY (`episodioId`) REFERENCES `EpisodioAtencion`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Orden` ADD CONSTRAINT `Orden_episodioId_fkey` FOREIGN KEY (`episodioId`) REFERENCES `EpisodioAtencion`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `OrdenItem` ADD CONSTRAINT `OrdenItem_ordenId_fkey` FOREIGN KEY (`ordenId`) REFERENCES `Orden`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Resultado` ADD CONSTRAINT `Resultado_ordenId_fkey` FOREIGN KEY (`ordenId`) REFERENCES `Orden`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PlanCobertura` ADD CONSTRAINT `PlanCobertura_aseguradoraId_fkey` FOREIGN KEY (`aseguradoraId`) REFERENCES `Aseguradora`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Afiliacion` ADD CONSTRAINT `Afiliacion_personaId_fkey` FOREIGN KEY (`personaId`) REFERENCES `PersonaAtendida`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Afiliacion` ADD CONSTRAINT `Afiliacion_planId_fkey` FOREIGN KEY (`planId`) REFERENCES `PlanCobertura`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Arancel` ADD CONSTRAINT `Arancel_prestacionCodigo_fkey` FOREIGN KEY (`prestacionCodigo`) REFERENCES `Prestacion`(`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Arancel` ADD CONSTRAINT `Arancel_planId_fkey` FOREIGN KEY (`planId`) REFERENCES `PlanCobertura`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Factura` ADD CONSTRAINT `Factura_personaId_fkey` FOREIGN KEY (`personaId`) REFERENCES `PersonaAtendida`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Factura` ADD CONSTRAINT `Factura_aseguradoraId_fkey` FOREIGN KEY (`aseguradoraId`) REFERENCES `Aseguradora`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FacturaItem` ADD CONSTRAINT `FacturaItem_facturaId_fkey` FOREIGN KEY (`facturaId`) REFERENCES `Factura`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `FacturaItem` ADD CONSTRAINT `FacturaItem_prestacionCodigo_fkey` FOREIGN KEY (`prestacionCodigo`) REFERENCES `Prestacion`(`codigo`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Pago` ADD CONSTRAINT `Pago_facturaId_fkey` FOREIGN KEY (`facturaId`) REFERENCES `Factura`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BitacoraAccesos` ADD CONSTRAINT `BitacoraAccesos_usuarioId_fkey` FOREIGN KEY (`usuarioId`) REFERENCES `Usuario`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
