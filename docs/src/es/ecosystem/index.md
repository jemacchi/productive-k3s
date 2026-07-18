# Ecosistema

Esta sección explica el modelo conceptual de Productive K3S antes de que entres en el detalle técnico de cada repositorio.

Usala cuando quieras entender:

- cómo encajan las piezas públicas entre sí;
- qué componentes son independientes y cuáles construyen sobre otros;
- dónde entra la experiencia recomendada vía CLI;
- cómo viven en capas distintas las soluciones curadas de despliegue y las extensiones curadas del cluster.

## Modelo conceptual

- `Productive K3S Core` es la base técnica. Podés usarlo por sí solo cuando querés el camino directo más simple hacia una base real de Kubernetes.
- `Productive K3S Infra` construye sobre `Core` y resuelve la orquestación de despliegues sobre distintas plataformas.
- `Productive K3S Profiles` define soluciones curadas de despliegue que `Infra` puede interpretar y ejecutar.
- `Productive K3S Addons` define extensiones curadas del cluster que `Core` puede instalar.
- `Productive K3S CLI` es la interfaz unificada más simple y recomendada, pero no es obligatoria.

## Independencia y dependencias

- `Core` puede usarse directamente.
- `Infra` depende de `Core`, pero no de `CLI`.
- `CLI` está recomendado por simplicidad, no es un requisito de corrección.
- `Profiles` y `Addons` son capas curadas distintas: soluciones de despliegue vs extensiones del cluster.

## Páginas

- [Mapa de repositorios](repositories.md)
- [Límites entre repositorios](boundaries.md)
