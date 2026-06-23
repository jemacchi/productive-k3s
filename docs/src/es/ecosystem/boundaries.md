# Límites Entre Repositorios

La claridad pública depende de mantener cada repositorio enfocado.

## `productive-k3s`

Posee la explicación del ecosistema, la navegación pública, el roadmap, los quickstarts y el contenido público del sitio.

## `productive-k3s-core`

Posee el runtime y el motor base de instalación, los addons core soportados, los scripts de lifecycle y la validación técnica de la plataforma base.

## `productive-k3s-infra`

Posee el runtime engine usado para ejecutar profiles empaquetados, además de la lógica de provisioning, las capas OpenTofu y Ansible, y la automatización reusable.

## `productive-k3s-profiles`

Posee el árbol fuente público de profiles/scenarios que alimenta la generación de paquetes y las pruebas de compatibilidad del engine.

## `productive-k3s-cli`

Posee la experiencia de línea de comandos orientada al usuario y debería mapear a los usuarios hacia bundles compatibles de core e infra.

## `productive-k3s-addons`

Posee integraciones opcionales, experimentos y caminos de extensión no core.

## `productive-k3s-profiles-pro`

Posee perfiles privados o comerciales que no deberían publicarse a través de los repositorios públicos.

## Regla general

Si el contenido explica el ecosistema a nivel público, probablemente pertenece acá.

Si documenta detalles de implementación, normalmente debería vivir en el repositorio dueño de esa implementación.
