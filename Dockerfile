FROM docker.io/nginxinc/nginx-unprivileged:alpine-slim

# Copiamos tus archivos
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Cambiamos a root momentáneamente para ajustar permisos de carpetas de sistema
USER root

# OpenShift usa IDs de usuario aleatorios pero que siempre pertenecen al grupo GID 0 (root)
# Damos permisos de escritura al grupo en las carpetas que Nginx necesita
RUN chmod -R g+w /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d

# Volvemos al usuario sin privilegios
USER 101

EXPOSE 8080