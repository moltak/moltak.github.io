import type { Site, Metadata, Socials } from "@types";

export const SITE: Site = {
  NAME: "Kh Jung",
  EMAIL: "moltak@gmail.com",
  NUM_POSTS_ON_HOMEPAGE: 20,
  NUM_WORKS_ON_HOMEPAGE: 2,
  NUM_PROJECTS_ON_HOMEPAGE: 3,
};

export const HOME: Metadata = {
  TITLE: "개발과 AI, 일상 속 배움을 기록하는 블로그",
  DESCRIPTION: "개발자 Kh Jung이 백엔드와 클라우드, AI와 개발 도구를 공부하고 직접 사용하며 겪은 경험을 기록합니다. 기술을 만들고 배우는 과정과 일상에서 발견한 생각도 함께 나눕니다.",
};

export const BLOG: Metadata = {
  TITLE: "개발과 AI, 기술 경험을 담은 글",
  DESCRIPTION: "백엔드 개발과 클라우드, AI와 개발 도구, 리눅스까지 직접 배우고 사용하며 쌓은 경험을 정리한 Kh Jung의 블로그 글 모음입니다.",
};

export const SOCIALS: Socials = [
  {
    NAME: "twitter-x",
    HREF: "https://twitter.com/markhorn_dev",
  },
];
