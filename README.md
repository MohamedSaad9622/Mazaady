<h1>MazaadyTask</h1>

<p>
  An iOS application built using <strong>UIKit</strong>, <strong>Combine</strong>, and <strong>Clean Architecture</strong> principles. It demonstrates modern iOS development practices like modularization, MVVM, dependency injection, and protocol-oriented programming.
</p>

<h2>📐 Architecture Decisions</h2>
<ul>
  <li><strong>Clean Architecture:</strong> Divides the app into Presentation, Domain, and Data layers for separation of concerns and scalability.</li>
  <li><strong>MVVM:</strong> The Presentation Layer uses UIKit with ViewModels that expose Combine publishers for reactive UI updates.</li>
  <li><strong>Combine:</strong> Used for binding and reactive programming to simplify state management and user interaction handling.</li>
  <li><strong>Dependency Injection:</strong> All dependencies are injected, promoting testability and flexibility.</li>
  <li><strong>Protocol-Oriented Programming:</strong> All interactions are abstracted via protocols for decoupling and easier unit testing.</li>
</ul>

<h2>🚀 How to Run the Project</h2>
<ol>
  <li>Clone the repository:
    <pre><code>git clone https://github.com/MohamedSaad9622/MazaadyTask.git</code></pre>
  </li>
  <li>Open <code>MazaadyTask.xcodeproj</code> in Xcode.</li>
  <li>Select the appropriate simulator and hit <strong>Run</strong> (Cmd + R).</li>
</ol>
