import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Button, Section, Stack, Box, NoticeBox } from 'tgui-core/components';

const perks = [
  {
    id: 'doubleshot',
    name: 'Double shot',
    desc: 'Shoots an arrow, and after 0.2 seconds automatically pulls out a second arrow from the quiver and launches it after the first.',
    color: 'red',
  },
  {
    id: 'longshot',
    name: 'Long-range shot',
    desc: 'Careful aiming. The shot damage significantly increases depending on the distance to the target.',
    color: 'purple',
  },
  {
    id: 'backstep',
    name: 'Bounce Shot',
    desc: 'Shoots at the target while simultaneously making a backward jump. After landing, movement speed temporarily increases.',
    color: 'blue',
  },
];

interface Data {
  has_perk: boolean;
  selected_perk: string;
}

export const ArcheryPerks = () => {
  const { act, data } = useBackend<Data>();
  const { has_perk, selected_perk } = data;

  return (
    <Window title="Expert Shooting Style" width={550} height={350}>
      <Window.Content>
        {has_perk && (
          <NoticeBox info>
            You have already chosen your path of mastery. It cannot be changed.
          </NoticeBox>
        )}
        <Section fill scrollable title="Available Styles">
          <Stack vertical fill>
            {perks.map((perk) => {
              const isSelected = selected_perk === perk.id;
              
              return (
                <Section key={perk.id}>
                  <Stack fill justify="space-between" align="center">
                    <Stack.Item grow>
                      <Box bold fontSize="14px" color={isSelected ? 'green' : perk.color}>
                        {perk.name}
                      </Box>
                      <Box color="label" mt={1}>
                        {perk.desc}
                      </Box>
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        color={isSelected ? 'green' : perk.color}
                        disabled={has_perk}
                        onClick={() => act('select_perk', { perk_id: perk.id })}
                      >
                        {isSelected ? 'Selected' : 'Select'}
                      </Button>
                    </Stack.Item>
                  </Stack>
                </Section>
              );
            })}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
