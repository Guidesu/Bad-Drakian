import { ColorButton, ensureColorHash, LabeledGridList } from 'pm/components';
import type { Customizer, CustomizerChoice } from 'pm/tabs/CharacterCreator/data';
import { useBackendStrict } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

interface WingsCustomizer extends CustomizerChoice {
  wings_color: string;
  natural_gradient: string;
  natural_color: string;
  dye_gradient: string;
  dye_color: string;
  allows_natural_gradient: BooleanLike;
  allows_dye_gradient: BooleanLike;
}

const gradientName = (value: string) => {
  const name = value.split('/').pop() || 'none';
  return name === 'none' ? 'None' : name.replaceAll('_', ' ');
};

export const FeatureChoiceWings = (props: { customizer: Customizer }) => {
  const { customizer } = props;
  const { act } = useBackendStrict();
  const choices = customizer.choices as WingsCustomizer;
  const action = (customizer_task: string) =>
    act('change_customizer', {
      customizer: customizer.type,
      customizer_task,
    });

  return (
    <Stack.Item>
      <LabeledGridList>
        <LabeledGridList.Item label="Wing Color">
          <ColorButton
            backgroundColor={choices.wings_color}
            tooltip={ensureColorHash(choices.wings_color)}
            onClick={() => action('wings_color')}
          />
        </LabeledGridList.Item>
        {!!choices.allows_natural_gradient && (
          <>
            <LabeledGridList.Item label="Natural Gradient">
              <Button fluid onClick={() => action('natural_gradient')}>
                {gradientName(choices.natural_gradient)}
              </Button>
            </LabeledGridList.Item>
            <LabeledGridList.Item label="Natural Color">
              <ColorButton
                backgroundColor={choices.natural_color}
                tooltip={ensureColorHash(choices.natural_color)}
                onClick={() => action('natural_color')}
              />
            </LabeledGridList.Item>
          </>
        )}
        {!!choices.allows_dye_gradient && (
          <>
            <LabeledGridList.Item label="Dye Gradient">
              <Button fluid onClick={() => action('dye_gradient')}>
                {gradientName(choices.dye_gradient)}
              </Button>
            </LabeledGridList.Item>
            <LabeledGridList.Item label="Dye Color">
              <ColorButton
                backgroundColor={choices.dye_color}
                tooltip={ensureColorHash(choices.dye_color)}
                onClick={() => action('dye_color')}
              />
            </LabeledGridList.Item>
          </>
        )}
      </LabeledGridList>
    </Stack.Item>
  );
};
