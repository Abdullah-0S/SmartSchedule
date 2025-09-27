import { useState } from "react";
import { Header } from "./components/Header";
import { Sidebar } from "./components/Sidebar";
import { MainForm } from "./components/MainForm";
import { Dashboard } from "./components/Dashboard";
import { Footer } from "./components/Footer";

export default function App() {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [currentPage, setCurrentPage] = useState("dashboard");

  const toggleSidebar = () => {
    setSidebarOpen(!sidebarOpen);
  };

  const closeSidebar = () => {
    setSidebarOpen(false);
  };

  const handleNavigate = (page: string) => {
    setCurrentPage(page);
  };

  const renderCurrentPage = () => {
    switch (currentPage) {
      case "dashboard":
        return <Dashboard />;
      case "course-preferences":
        return <MainForm />;
      case "schedule":
        return (
          <div className="p-6">
            <h1 className="text-3xl font-bold mb-6">Schedule</h1>
            <p className="text-muted-foreground">Schedule page coming soon...</p>
          </div>
        );
      case "profile":
        return (
          <div className="p-6">
            <h1 className="text-3xl font-bold mb-6">Profile</h1>
            <p className="text-muted-foreground">Profile page coming soon...</p>
          </div>
        );
      case "settings":
        return (
          <div className="p-6">
            <h1 className="text-3xl font-bold mb-6">Settings</h1>
            <p className="text-muted-foreground">Settings page coming soon...</p>
          </div>
        );
      default:
        return <Dashboard />;
    }
  };

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <Header onMenuClick={toggleSidebar} />
      
      <div className="relative">
        {/* Sidebar */}
        <Sidebar 
          isOpen={sidebarOpen} 
          onClose={closeSidebar}
          currentPage={currentPage}
          onNavigate={handleNavigate}
        />
        
        {/* Main Content */}
        <main 
          className={`transition-all duration-300 ease-in-out min-h-[calc(100vh-8rem)] ${
            sidebarOpen ? "lg:ml-64" : "ml-0"
          }`}
        >
          {renderCurrentPage()}
        </main>
        
        {/* Footer */}
        <div
          className={`transition-all duration-300 ease-in-out ${
            sidebarOpen ? "lg:ml-64" : "ml-0"
          }`}
        >
          <Footer />
        </div>
      </div>
    </div>
  );
}