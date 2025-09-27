import { useState } from "react";
import { Button } from "./ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "./ui/select";
import { Label } from "./ui/label";
import { Badge } from "./ui/badge";
import { X } from "lucide-react";

interface SelectedOption {
  value: string;
  label: string;
  order: number;
}

export function MainForm() {
  const [selectedOptions, setSelectedOptions] = useState<SelectedOption[]>([]);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Form submitted with options in order:", selectedOptions);
    // Handle form submission here
  };

  const options = [
    { value: "course1", label: "Introduction to Computer Science" }, //TODO
    { value: "course2", label: "Data Structures and Algorithms" },
    { value: "course3", label: "Web Development Fundamentals" },
    { value: "course4", label: "Database Management Systems" },
    { value: "course5", label: "Software Engineering Principles" },
    { value: "course6", label: "Machine Learning Basics" },
    { value: "course7", label: "Mobile App Development" },
    { value: "course8", label: "Cybersecurity Fundamentals" },
  ];

  const handleOptionSelect = (value: string) => {
    const option = options.find(opt => opt.value === value);
    if (option && !selectedOptions.find(selected => selected.value === value)) {
      const newOption: SelectedOption = {
        ...option,
        order: selectedOptions.length + 1
      };
      setSelectedOptions([...selectedOptions, newOption]);
    }
  };

  const removeOption = (valueToRemove: string) => {
    const updatedOptions = selectedOptions
      .filter(option => option.value !== valueToRemove)
      .map((option, index) => ({ ...option, order: index + 1 }));
    setSelectedOptions(updatedOptions);
  };

  const availableOptions = options.filter(
    option => !selectedOptions.find(selected => selected.value === option.value)
  );

  return (
    <div className="flex items-center justify-center min-h-[calc(100vh-4rem)] p-8">
      <div className="w-full max-w-lg bg-card rounded-2xl border border-border p-8 shadow-lg">
        <h2 className="text-2xl font-medium mb-6 text-center">Course Preferences</h2>
        
        <form onSubmit={handleSubmit} className="space-y-6">
          <div className="space-y-2">
            <Label htmlFor="select-option">Choose courses in order</Label>
            <Select key={selectedOptions.length} onValueChange={handleOptionSelect}>
              <SelectTrigger id="select-option" className="w-full">
                <SelectValue placeholder={availableOptions.length > 0 ? "Select Course..." : "All courses selected"} />
              </SelectTrigger>
              <SelectContent className="z-[100]">
                {availableOptions.map((option) => (
                  <SelectItem key={option.value} value={option.value}>
                    {option.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {/* Selected Options Display */}
          {selectedOptions.length > 0 && (
            <div className="space-y-3">
              <Label>Your course order:</Label>
              <div className="space-y-2 max-h-48 overflow-y-auto">
                {selectedOptions.map((option) => (
                  <div
                    key={option.value}
                    className="flex items-center gap-3 p-3 bg-accent rounded-lg border"
                  >
                    <Badge variant="secondary" className="shrink-0">
                      #{option.order}
                    </Badge>
                    <span className="flex-1 text-sm">{option.label}</span>
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      onClick={() => removeOption(option.value)}
                      className="h-6 w-6 p-0 hover:bg-destructive hover:text-destructive-foreground"
                    >
                      <X className="h-4 w-4" />
                    </Button>
                  </div>
                ))}
              </div>
            </div>
          )}
          
          <Button 
            type="submit" 
            className="w-full" 
            disabled={selectedOptions.length === 0}
          >
            Submit courses ({selectedOptions.length} courses)
          </Button>
        </form>
      </div>
    </div>
  );
}