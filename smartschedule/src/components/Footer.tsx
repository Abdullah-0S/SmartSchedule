import { GitHubIcon } from './icons/GitHubIcon';
import linkedinIcon from 'figma:asset/eb0a7e1284e631d80c3225c0e2d6c7af931de535.png';

export interface TeamMember {
  name: string;
  github: string;
  linkedin: string;
}

interface FooterProps {
  team?: TeamMember[];
  className?: string;
}

export function Footer({ team, className = "" }: FooterProps) {
  const defaultTeam: TeamMember[] = [
    {
      name: "Abdullah Alsuhaibani",
      github: "https://github.com/Abdullah-0S",
      linkedin: "https://www.linkedin.com/in/abdullahalsuhaibani/"
    },
    {
      name: "Sulaiman Mokhaniq",
      github: "https://github.com/sulaimanmokhaniq",
      linkedin: "https://www.linkedin.com/in/sulaiman-mokhaniq/"
    },
    {
      name: "Waleeed Khalid",
      github: "https://github.com/waleeedkhalid",
      linkedin: "https://www.linkedin.com/in/w4leedkhalid"
    },
    {
      name: "Hamza Hamdi",
      github: "https://github.com/hamza808111",
      linkedin: "https://linkedin.com/in/" //TODO
    },
    {
      name: "Abderraouf Bendjedia",
      github: "https://github.com/Abderraouf17",
      linkedin: "https://linkedin.com/in/" //TODO
    }
  ];

  const teamMembers = team || defaultTeam;

  return (
    <footer className={`bg-gray-900 border-t border-gray-800 py-8 px-8 ${className}`}>
      <div className="max-w-4xl mx-auto text-center">
        <h3 className="text-white text-lg mb-6">Made by:</h3>
        <div className="flex flex-wrap justify-center gap-6">
          {teamMembers.map((member) => (
            <div key={member.name} className="flex items-center gap-3">
              <span className="text-gray-200 text-base">{member.name}</span>
              <div className="flex items-center gap-2">
                <a
                  href={member.github}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-white hover:opacity-80 transition-opacity flex items-center"
                  title={`${member.name}'s GitHub`}
                >
                  <GitHubIcon className="w-6 h-6" />
                </a>
                <a
                  href={member.linkedin}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="hover:opacity-80 transition-opacity flex items-center"
                  title={`${member.name}'s LinkedIn`}
                >
                  <img
                    src={linkedinIcon}
                    alt="LinkedIn"
                    className="h-6 w-auto rounded-sm"
                  />
                </a>
              </div>
            </div>
          ))}
        </div>
      </div>
    </footer>
  );
}