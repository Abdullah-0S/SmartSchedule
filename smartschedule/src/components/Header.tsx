import { Menu } from "lucide-react";
import { Button } from "./ui/button";

interface HeaderProps {
  onMenuClick: () => void;
}

export function Header({ onMenuClick }: HeaderProps) {
  return (
    <header className="w-full h-16 bg-card border-b border-border flex items-center px-4">
      <Button
        variant="ghost"
        size="icon"
        onClick={onMenuClick}
        className="mr-4"
      >
        <Menu className="h-6 w-6" />
      </Button>
      <h1 className="text-xl font-medium">Smart Schedule</h1>
    </header>
  );
}