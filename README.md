# Ejemplo Flutter: Autenticación con FirebaseAuth

Este es un proyecto de ejemplo que ilustra cómo usar FirebaseAuth para hacer una
página de *login* con varias formas de autenticación. La aplicación tiene una
página principal vacía que simplemente muestra los datos del usuario.

El núcleo de la estructura es un `StreamBuilder` que escucha el *stream* de
FirebaseAuth llamado `onAuthStateChanged` y decide si mostrar la página
principal (cuando el usuario existe) o la página de *login* (si el usuario no
existe).