import { X, LayoutDashboard, Calendar, User, Settings, LogOut, BookOpen } from "lucide-react";
import { Button } from "./ui/button";

interface SidebarProps {
  isOpen: boolean;
  onClose: () => void;
  currentPage: string;
  onNavigate: (page: string) => void;
}

export function Sidebar({ isOpen, onClose, currentPage, onNavigate }: SidebarProps) {
  // Mock user data - in a real app, this would come from authentication context
  const user = {
    name: "USER NAME",
    email: "EMAIL@example.com"
  };

  const menuItems = [
    { icon: LayoutDashboard, label: "Dashboard", page: "dashboard" },
    { icon: BookOpen, label: "Course Preferences", page: "course-preferences" },
    { icon: Calendar, label: "Schedule", page: "schedule" },
    { icon: User, label: "Profile", page: "profile" },
    { icon: Settings, label: "Settings", page: "settings" },
  ];

  const handleLogout = () => {
    // Handle logout logic here
    console.log("User logged out");
    onClose();
  };

  return (
    <>
      {/* Overlay */}
      {isOpen && (
        <div
          className="fixed inset-0 bg-black/50 z-40 lg:hidden"
          onClick={onClose}
        />
      )}
      
      {/* Sidebar */}
      <div
        className={`fixed left-0 top-16 h-[calc(100vh-4rem)] w-64 bg-card border-r border-border z-50 transform transition-transform duration-300 ease-in-out ${
          isOpen ? "translate-x-0" : "-translate-x-full"
        }`}
      >
        <div className="flex flex-col h-full">
          {/* Header */}
          <div className="flex items-center justify-between p-4 border-b border-border">
            <div className="flex flex-col">
              <h2 className="text-lg font-medium">Welcome, {user.name}</h2>
              <p className="text-sm text-muted-foreground">{user.email}</p>
            </div>
            <Button variant="ghost" size="icon" onClick={onClose}>
              <X className="h-5 w-5" />
            </Button>
          </div>
          
          {/* Navigation */}
          <nav className="flex-1 p-4">
            <ul className="space-y-2">
              {menuItems.map((item) => (
                <li key={item.label}>
                  <button
                    onClick={() => {
                      onNavigate(item.page);
                      onClose(); // Close sidebar after navigation on mobile
                    }}
                    className={`flex items-center gap-3 px-3 py-2 rounded-lg transition-colors w-full text-left ${
                      currentPage === item.page
                        ? "bg-primary text-primary-foreground"
                        : "hover:bg-accent hover:text-accent-foreground"
                    }`}
                  >
                    <item.icon className="h-5 w-5" />
                    <span>{item.label}</span>
                  </button>
                </li>
              ))}
            </ul>
          </nav>
          
          {/* Logout Button at Bottom */}
          <div className="p-4 border-t border-border">
            <Button
              variant="ghost"
              className="w-full justify-start text-destructive hover:text-destructive hover:bg-destructive/10"
              onClick={handleLogout}
            >
              <LogOut className="h-5 w-5 mr-3" />
              Log Out
            </Button>
          </div>
        </div>
      </div>
    </>
  );
}