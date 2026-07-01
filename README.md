<h1 align="center">MATLAB-ISS-Orbit-Propagator</h1>
<img align= "center" width="750" height="717" alt="PORTADA README" src="https://github.com/user-attachments/assets/569eeee2-3597-49c2-b6c2-b6ef49b6aced" /> </br>
This project is simulation of the International Space Station's orbit using fourth order Runge-Kutta method under a two-body gravitational model. With the data, the program generates:
<ul> <li>A 3D visualization of the ISS orbit around a textured Earth during the selected time</li>
<li>The ground track over the Earth's surface</li>
<li>The option of generating an animation that can be exported as an MP4 video</li></ul>
<h1>The Physical Model</h1>
The current simulation assumes several conditions:
<ul><li>Takes Earth asa perfect sphere</li>
<li>It only takes into account the Earth's gravitational attraction</li>
<li>There is not atmopheric drag</li>
<li>Takes a constant Earth rotation rate (7.292*1e-5 rad/s)</li></ul>
<h1 align="center">Fouth-Order Runge-Kutta Implementation</h1>
The ISS's motion equations are integrated using the RK4 method with a fixed time step that the user can change anytime. Given the initial conditions (coordinates, attitude, azimuth angle and absolute velocity), the simulation generates a state vector that contains the position a velocity data measured from a fixed (non-rotating) frame of reference in which the X axis points to the coordinates 0º 0º at the beginning of the simulation. In every iteartion the algorithm computes the ISS's position, velocity, distance from Earth's center
