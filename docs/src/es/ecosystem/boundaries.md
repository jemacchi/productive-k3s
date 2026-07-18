# Límites Entre Repositorios

La claridad pública depende de mantener cada repositorio enfocado.

## `productive-k3s`

Posee la explicación del ecosistema, la navegación pública, el roadmap, los quickstarts y el contenido público del sitio.

## `productive-k3s-core`

Posee el contrato base de instalación Kubernetes, los modos de ensamblado del cluster y la instalación de paquetes de addons o stacks.

## `productive-k3s-infra`

Posee la capa de despliegue y orquestación que interpreta caminos curados de solución sobre Core.

## `productive-k3s-profiles`

Posee las soluciones curadas públicas de despliegue y el árbol fuente que las define.

## `productive-k3s-cli`

Posee la interfaz de comandos orientada a usuarios más simple y recomendada para todo el ecosistema.

## `productive-k3s-addons`

Posee extensiones curadas del cluster que Core puede instalar como addons o stacks agrupados.

## Regla general

Si el contenido explica el ecosistema a nivel público, probablemente pertenece acá.

Si documenta detalles de implementación, normalmente debería vivir en el repositorio dueño de esa implementación.
