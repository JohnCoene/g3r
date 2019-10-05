HTMLWidgets.widget({

  name: 'g3r',

  type: 'output',

  factory: function(el, width, height) {

    var renderer,
        canvas,
        camera,
        controls;

    return {

      renderValue: function(x) {

        canvas = document.getElementById(el.id + '-canvas');
        camera = new THREE.PerspectiveCamera(75, canvas.width/canvas.height, 0.1, 1000);
        camera.position.set(0, 0, 1.5);
        camera.up.set(0, 0, 1); // important for OrbitControls
        renderer = new THREE.WebGLRenderer({
            // alpha: true,
            canvas: canvas,
        });
        controls = new THREE.OrbitControls(camera, renderer.domElement);
        // object stuff --------
        var scene = new THREE.Scene();
        var walls = new THREE.LineSegments(
            new THREE.EdgesGeometry(new THREE.BoxBufferGeometry(1, 1, 1)),
            new THREE.LineBasicMaterial({color: 0xcccccc}));
        walls.position.set(0, 0, 0);
        scene.add(walls);
        scene.add(new THREE.AxesHelper(1));
        // render stuff --------
        var render = () => {
            renderer.render(scene, camera);
        };
        // main --------
        render(); // first time
        controls.addEventListener('change', render);
        var tgeo = new ThreeGeo({
            tokenMapbox: 'pk.eyJ1IjoiamNvZW5lcCIsImEiOiJjamwyYXJyMjExb2R0M3FxcDlmemg2czFiIn0.OL6qEEADz5qBjhKecwgBdg', // <---- set your Mapbox API token here
        });
        tgeo.getTerrain([45.925461, 6.869810], 5.0, 12, {
          onRgbDem: (meshes) => { // your implementation when terrain's geometry is obtained
              meshes.forEach((mesh) => { scene.add(mesh); });
              render(); // now render scene after dem meshes are added
          },
          onSatelliteMat: (mesh) => { // your implementation when terrain's satellite texture is obtained
              render(); // now render scene after dem material (satellite texture) is applifed
          },
      });

      },

      resize: function(width, height) {

        if(renderer){
          renderer.setSize(width, height, false);
          camera.aspect = width / height;
          camera.updateProjectionMatrix();
        }

      }

    };
  }
});