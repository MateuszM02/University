interface SkillGroup {
  title: string;
  skills: Skill[];
}

interface Skill {
  name: string;
  imageSrc: string;
}

/* Frontend Skills */

const React: Skill = {
  name: "React",
  imageSrc: "https://seeklogo.net/wp-content/uploads/2020/09/react-logo.png",
};

const HTML: Skill = {
  name: "HTML",
  imageSrc: "https://www.w3.org/html/logo/badge/html5-badge-h-solo.png",
};

const CSS: Skill = {
  name: "CSS",
  imageSrc:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/CSS3_logo_and_wordmark.svg/1452px-CSS3_logo_and_wordmark.svg.png",
};

const JavaScript: Skill = {
  name: "JavaScript",
  imageSrc:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/JavaScript-logo.png/800px-JavaScript-logo.png",
};

const BootStrap: Skill = {
  name: "Bootstrap",
  imageSrc:
    "https://getbootstrap.com/docs/5.3/assets/brand/bootstrap-logo-shadow.png",
};

/* Backend Skills */

const Java: Skill = {
  name: "Java",
  imageSrc:
    "https://raw.githubusercontent.com/devicons/devicon/master/icons/java/java-original.svg",
};

const Cpp: Skill = {
  name: "C++",
  imageSrc:
    "https://logos-download.com/wp-content/uploads/2022/11/C_Logo-1820x2048.png",
};

const CSharp: Skill = {
  name: "C#",
  imageSrc:
    "https://th.bing.com/th/id/R.4ca13324c0aa531d2122694b8eb37db9?rik=zSyPkhMiFY3THw&pid=ImgRaw&r=0",
};

const Rust: Skill = {
  name: "Rust",
  imageSrc: "https://logodix.com/logo/700854.png",
};

const MySQL: Skill = {
  name: "MySQL",
  imageSrc:
    "https://raw.githubusercontent.com/devicons/devicon/master/icons/mysql/mysql-original-wordmark.svg",
};

const MongoDB: Skill = {
  name: "MongoDB",
  imageSrc:
    "https://raw.githubusercontent.com/devicons/devicon/master/icons/mongodb/mongodb-original-wordmark.svg",
};

/* Machine Learning Skills */

const Python: Skill = {
  name: "Python",
  imageSrc:
    "https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg",
};

const PyTorch: Skill = {
  name: "PyTorch",
  imageSrc:
    "https://th.bing.com/th/id/R.30e5f549a467ec3afb008b4c98a3a0f1?rik=gcTuUgc1i80PPg&riu=http%3a%2f%2fblog.christianperone.com%2fwp-content%2fuploads%2f2018%2f10%2fpytorch-logo.png&ehk=OgJDKrhg%2fkfNwZTVRGskD%2fsByx8eK0s7P%2fX%2bB4Bahhk%3d&risl=&pid=ImgRaw&r=0",
};

const Jupyter: Skill = {
  name: "Jupyter",
  imageSrc:
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Jupyter_logo.svg/1767px-Jupyter_logo.svg.png",
};

/* SkillGroup */

const Frontend: SkillGroup = {
  title: "Frontend",
  skills: [React, HTML, CSS, JavaScript, BootStrap],
};

const Backend: SkillGroup = {
  title: "Backend",
  skills: [Java, Cpp, CSharp, Rust],
};

const MachineLearning: SkillGroup = {
  title: "Machine Learning",
  skills: [Python, PyTorch, Jupyter],
};

/* function transforming skill group into component */

const SkillGroupComponent = ({ skillGroup }: { skillGroup: SkillGroup }) => {
  return (
    <div className="SkillGroupContainer">
      <div className="SkillGroupTitle">{skillGroup.title}</div>
      <div className="SkillList">
        {skillGroup.skills.map((skill) => (
          <SkillComponent skill={skill} />
        ))}
      </div>
    </div>
  );
};

/* function transforming skill into component */

const SkillComponent = ({ skill }: { skill: Skill }) => {
  return (
    <div className="SkillItem">
      <img className="SkillImage" src={skill.imageSrc} />
      <label className="SkillName">{skill.name}</label>
    </div>
  );
};

export const SkillList = () => {
  return (
    <div className="SkillsContainer">
      <SkillGroupComponent skillGroup={Frontend} />
      <SkillGroupComponent skillGroup={Backend} />
      <SkillGroupComponent skillGroup={MachineLearning} />
    </div>
  );
};
