"use client";
import { FullPageChat } from "flowise-embed-react";

export default function Home() {
  return (
    <FullPageChat
      chatflowid=""
      apiHost="http://localhost:3030"
      theme={{
        chatWindow: {
          showTitle: true,
          title: "Demo - Chat AI",
          showAgentMessages: false,
          welcomeMessage: `Olá! Como posso te ajudar hoje?`,
          errorMessage: "Ocorreu um erro. Por favor, tente novamente.",
          height: "800",
          Radius: "16",
          botMessage: {
            showAvatar: true,
            avatarSrc: "/Robot.svg",
          },
          userMessage: {
            showAvatar: true,
            avatarSrc: "/User.svg",
          },
          textInput: {
            placeholder: "Digite sua pergunta",

            maxChars: 300,
            maxCharsWarningMessage:
              "Você excedeu o limite de caracteres. Por favor, digite menos de 300 caracteres.",
            autoFocus: true,
            sendMessageSound: true,
            receiveMessageSound: true,
          },
          footer: {
            text: "Bots podem cometer erros. Verifique informações importantes.",
            company: "Flowise.com",
            companyLink: "https://flowiseai.com",
          },
        },
      }}
    />
  );
}
